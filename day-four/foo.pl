#!/usr/bin/env perl

use Data::Dumper;
use strict;
use warnings;

my $first = 16;
my $last  = 61;

my @range = ($first..$last);

print Dumper \@range;
exit();

for my $num ($first..$last) {
    print $num, "\n";
}
