#!/usr/bin/env perl

use Data::Dumper;
use strict;
use warnings;

$Data::Dumper::Indent = 1;

open(my $fh, '<', 'dayseven-input.txt') || die "Could not open dayseven-input.txt - $!\n";

my @tree_directories;
my %directory_sizes;

my $cwd;

while(<$fh>) {
    chomp;
    my $input = $_;
    
    if ($input =~ /\$ cd (.+)/) {
        if ($1 eq '/') {
            @tree_directories = ('/');
        } elsif ($1 eq '..') {
            # here we'll just remove the last seen directory
            # assumption: input doesn't cd .. without listing files first
            pop(@tree_directories);
            # this will break if assumption wrong...
        } else {
            # here we just add the current cwd to our tree directories
            my $child  = $1;
            
            $cwd = $tree_directories[-1] eq '/' ? $tree_directories[-1] . $child 
                : $tree_directories[-1] . '/' . $child;

            push(@tree_directories, $cwd);
        }
    } elsif ($input =~ /^(\d+)/) {
        my $bytes = $1;
        # handle filesizes and and add to all tree directories
        for my $directory (@tree_directories) {
            $directory_sizes{$directory} += $bytes;
        }
    }
}
    
close($fh);

# part one solution:
my $total_bytes = 0;

for my $size_of_directory (values(%directory_sizes)) {
    if ($size_of_directory <= 100000) {
        $total_bytes += $size_of_directory;
    }
}

print "SOLUTION 1: $total_bytes\n";

# part two solution:
for my $directory_size (sort { $directory_sizes{$a} <=> $directory_sizes{$b} } keys(%directory_sizes)) {
    if ((70000000 - $directory_sizes{'/'} + $directory_sizes{$directory_size}) >= 30000000) {
        print "SOLUTION 2: $directory_sizes{$directory_size}\n";
        last;
    }
}
