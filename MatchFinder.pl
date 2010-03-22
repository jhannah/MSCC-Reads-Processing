#!/usr/bin/perl
use warnings;

my $MISMATCH = 2;

$start = $ARGV[0];
$end = $ARGV[1];
$INCREMENT = $ARGV[2];

my $base_dir = '/home/biocore/jhannah/src/MSCC-Reads-Processing';
my $work_dir = "$base_dir/work";
my $file1 =    "$work_dir/CCGG_tags_18_withdist_shuffled";
my $file2 =    "$work_dir/CCGG_tags_18_withdist_alphasort";

my $out = "CCGG_tags_18_upto2MM_${start}_${end}";

my ($tagfilename, $variantfilename, $sortedvariantfilename, $matchfilename);

$tagfilename = "reads_" . $start . "_" . $end;
$variantfilename = $tagfilename . "_variants";
$sortedvariantfilename = $variantfilename . "_sorted";
$matchfilename = $tagfilename . "_matches";

my $cmd;
if ($end < $start + $INCREMENT) {
   my $tail = $end - $start;
   $cmd = "tail -$tail $file1 > $work_dir/$tagfilename";
} else {
   $cmd = "head -$end $file1 | tail -$INCREMENT > $work_dir/$tagfilename";
}

foreach my $cmd (
   $cmd,
   "$base_dir/GenerateVariants_3MM.pl $work_dir/$tagfilename $MISMATCH > $work_dir/$variantfilename",
   "sort $work_dir/$variantfilename > $work_dir/$sortedvariantfilename",
   "rm $work_dir/$variantfilename",
   "join $file2 $work_dir/$sortedvariantfilename > $work_dir/$matchfilename",
   "rm $work_dir/$sortedvariantfilename",
   "sort --key=9,9 --key=10n,10 --key=11,11 --key=17n,17 $work_dir/$matchfilename > $work_dir/${out}_sorted",
   "$base_dir/CountMatches.pl $work_dir/${out}_sorted > $work_dir/${out}_counts",
   "cp $work_dir/${out}_counts /home/pm23/CCGG_mouse/find_unique_tags/${out}_counts",
   "rm $work_dir/$tagfilename",
   "rm $work_dir/$matchfilename",
   "rm $work_dir/${out}_sorted",
   "rm $work_dir/${out}_counts",
) {
   print "$cmd\n";
   `time $cmd`;
}


