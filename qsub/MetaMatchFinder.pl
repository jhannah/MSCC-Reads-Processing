#!/usr/bin/perl

use strict;
use warnings;
use Template;

my $INCREMENT = 2000;

my $base_dir = "/home/biocore/jhannah/src/MSCC-Reads-Processing";
my $work_file = "$base_dir/work/CCGG_tags_18_withdist_shuffled";
my ($lines) = `wc -l $work_file`;
$lines =~ s/ .*//s;

for (my $i = 0; $i < $lines; $i+=$INCREMENT) {
   my $start = $i;
   my $end = $i + $INCREMENT;
 
   if ($end > $lines) {
     $end = $lines;
   }

   my $file = "$base_dir/work/$start.$end.pbs";
   my $cmd =  "$base_dir/MatchFinder.pl $start $end $INCREMENT";
   print "$file\n$cmd\n";
   create_pbs_file($file, $cmd);
   qsub($file);
}


exit;

# ---------
# END MAIN
# ---------

sub qsub {
   my ($file) = @_;
   my $dir = $file;
   $dir =~ s#/[^/]+$##;
   my $cmd = "cd $dir; qsub -l nodes=1 $file";
   print "$cmd\n";
   `$cmd`;
}


sub create_pbs_file {
   my ($file, $cmd) = @_;
   my $config = {};
   my $template = Template->new($config);
   my $vars = {
      cmd => $cmd,
   };
   $template->process('run.pbs.tt', $vars, $file)
      || die $template->error();
}


