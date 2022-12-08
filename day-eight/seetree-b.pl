#!/usr/bin/env perl

use Data::Dumper;
use strict;
use warnings;

$Data::Dumper::Indent = 1;

open(my $fh, '<', 'dayeight-input.txt') || die "Could not open dayseven-input.txt - $!\n";

my @tree_grid;
my $cwd;

while(<$fh>) {
    chomp;
    my $input = $_;
    my @row   = split(//, $input);
    push(@tree_grid, [@row]);
}
    
close($fh);

print Dumper \@tree_grid;

my $grid_height   = @tree_grid;
my $grid_width    = @{$tree_grid[0]};
my $trees_visible = 0;

my @scores;

for my $i (0 .. ($grid_height - 1)) {
    for my $j (0 .. ($grid_width - 1)) {
        my $current_tree = $tree_grid[$i][$j];

        print "Current tree is: $current_tree at $i : $j\n";

        my $visible_left  = 0;
        my $visible_right = 0;
        my $visible_up    = 0;
        my $visible_down  = 0;

        # based on where the tree is, look left...
        my @trees_left;
        for my $tree (@{$tree_grid[$i]}[0 .. $j -1]) {
            push(@trees_left, $tree);
        }

        for my $left_tree (reverse @trees_left){
            $visible_left++;
            if ($current_tree <= $left_tree) { last; }
        }

        # same but look right...
        my @trees_right;
        for my $tree (@{$tree_grid[$i]}[$j + 1 .. $grid_width - 1]) {
            push(@trees_right, $tree);
        }

        for my $right_tree (@trees_right){
            $visible_right++;
            if ($current_tree <= $right_tree) { last; }
        }

        # same but look up...
        my @trees_up;
        for my $tree (map {$tree_grid[$_][$j]} 0 .. $i - 1) {
            push(@trees_up, $tree);
        }

        for my $up_tree (reverse @trees_up){
            $visible_up++;
            if ($current_tree <= $up_tree) { last; }
        }

        # same but look down...
        my @trees_down;
        for my $tree (map {$tree_grid[$_][$j]} $i + 1 .. $grid_height - 1) {
            push(@trees_down, $tree);
        }

        for my $down_tree (@trees_down){
            $visible_down++;
            if ($current_tree <= $down_tree) { last; }
        }

        my $score = ($visible_left * $visible_right * $visible_up * $visible_down);
        push(@scores, $score);
    }
}

print Dumper \@scores;

for my $score (sort { $b <=> $a } @scores) {
    print "SOLUTION 2: $score\n";
    last;
}

#print "\n\n\n";
#print $grid_height, "\n";
#print $grid_width, "\n";
