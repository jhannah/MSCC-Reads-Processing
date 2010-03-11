#!/usr/bin/perl

# This program is listed as a one-liner in matching.html. One-liners are hard to debug,
# though, so I'm pulling it out into a normal program.  --jhannah 20100311

$dist = 1000;
while (<>) {
   @data = split; 
   if ($data[3] eq "-") {
      if ($data[1] ne $olddata[1]) { 
         if (@olddata) { 
            print "@olddata[0..5] 1000 $data[6]\n";
         }
         print "@data[0..5] 1000 $data[6]\n"
      } else {
         $dist = $data[2] - $olddata[2]; 
         print "@olddata[0..5] $dist $data[6]\n@data[0..5] $dist $data[6]\n";
      } 
   }
   @olddata = @data;
}
print "@olddata[0..5] 1000 $data[6]\n";ii



