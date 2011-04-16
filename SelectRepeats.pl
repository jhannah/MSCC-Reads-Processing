#!/usr/bin/perl

use strict;

while (<>) {
   chomp;
   my @line = split / /;
   if ($line[5] == 1 && $line[6] >= 50 && $line[7] eq 'NA') {
      print "$_\n";
   }
}

