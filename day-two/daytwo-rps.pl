#!/usr/bin/env perl

use strict;
use warnings;

# TODO: increase the scores below for the value of the thing played (see instructions)

my %outcome_matrix = (
    AX => 4, # rock/rock
    AY => 8, # rock/paper
    AZ => 3, # rock/scissors
    BX => 1, # paper/rock
    BY => 5, # paper/paper
    BZ => 9, # paper/scissors
    CX => 7, # scissors/rock
    CY => 2, # scissors/paper
    CZ => 6, # scissors/scissors
);

my $file = 'day-two-input.txt';
open(my $fh, '<', $file) || die "Could not open $file - $!\n";

my $total_score = 0;
while(<$fh>) {
    chomp;
    my $line = $_;
    $line =~ s/\s+//;
    $total_score += $outcome_matrix{$line};
}

close($fh);

print "Total score is: $total_score\n";
