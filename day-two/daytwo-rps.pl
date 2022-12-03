#!/usr/bin/env perl

use strict;
use warnings;

my %first_outcome_matrix = (
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

my %second_outcome_matrix = (
    AX => 3, # rock/scissors (lose, scissors)
    AY => 4, # rock/rock (draw, rock)
    AZ => 8, # rock/paper (win, paper)
    BX => 1, # paper/rock (lose, rock)
    BY => 5, # paper/paper (draw, paper)
    BZ => 9, # paper/scissors (win, scissors)
    CX => 2, # scissors/paper (lose, paper)
    CY => 6, # scissors/scissors (draw, scissors)
    CZ => 7, # scissors/rock (win, rock)
);

my $file = 'day-two-input.txt';
open(my $fh, '<', $file) || die "Could not open $file - $!\n";

my $first_total_score  = 0;
my $second_total_score = 0;
while(<$fh>) {
    chomp;
    my $line = $_;
    $line =~ s/\s+//;
    $first_total_score  += $first_outcome_matrix{$line};
    $second_total_score += $second_outcome_matrix{$line};
}

close($fh);

print "First total score is:  $first_total_score\n";
print "Second total score is: $second_total_score\n";
