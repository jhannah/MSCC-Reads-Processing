#!/usr/bin/perl

# This program is listed as a one-liner in matching.html. One-liners are hard to debug,
# though, so I'm pulling it out into a normal program.  --jhannah 20100311

use strict;

my (@data, @olddata, $dist);
while (<>) {
   @data = split; 
   if ($data[3] eq "-") {
      if ($data[1] ne $olddata[1]) { 
         if (@olddata) { 
            print "@olddata[0..5] 1000 $data[6]\n";
         }
         print "@data[0..5] 1000 $data[6]\n"
      } else {
         print "@olddata[0..5] $dist $data[6]\n@data[0..5] $dist $data[6]\n";
      } 
   } else {
      $dist = @olddata ? $data[2] - $olddata[2] : 1000;
   }
   @olddata = @data;
}
print "@olddata[0..5] 1000 $data[6]\n";


