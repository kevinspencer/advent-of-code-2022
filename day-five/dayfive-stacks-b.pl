#!/usr/bin/env perl

use Data::Dumper;
use strict;
use warnings;

$Data::Dumper::Indent = 1;

my $stacks = [
    ['Q','G','P','R','L','C','T','F'],
    ['J','S','F','R','W','H','Q','N'],
    ['Q','M','P','W','H','B','F'],
    ['F','D','T','S','V'],
    ['Z','F','V','W','D','L','Q'],
    ['S','L','C','Z'],
    ['F','D','V','M','B','Z'],
    ['B','J','T'],
    ['H','P','S','L','G','B','N','Q'],
];

open(my $fh, '<', 'dayfive-input.txt') || die "Could not open dayfive-input.txt - $!\n";
while(<$fh>) {
    chomp;
    if (/move (\d+) from (\d) to (\d)/) {
        my $move_count = $1;
        my $move_from  = ($2 - 1);
        my $move_to    = ($3 - 1);

        restack_crates($move_count, $move_from, $move_to);
    }
}
close($fh);

for my $crate_stack (@$stacks) {
    print $crate_stack->[0];
}

sub restack_crates {
    my ($move_count, $move_from, $move_to) = @_;

    my @in_motion_crates;
    for my $crate (1 .. $move_count) {
        push(@in_motion_crates, shift(@{$stacks->[$move_from]}));
    }
    @in_motion_crates = reverse(@in_motion_crates);
    for my $crate_in_motion (@in_motion_crates) {
        unshift(@{$stacks->[$move_to]}, $crate_in_motion);
    }
}
