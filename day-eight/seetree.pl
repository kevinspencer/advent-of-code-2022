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

for my $i (0 .. ($grid_height - 1)) {
    for my $j (0 .. ($grid_width - 1)) {
        my $current_tree = $tree_grid[$i][$j];

        print "Current tree is: $current_tree at $i : $j\n";

        # trees around the perimeter are always visible...
        my $is_perimeter = ($i == 0 || $j == 0 || $i == $grid_height - 1 || $j == $grid_width -1);
        if ($is_perimeter) {
            $trees_visible++;
            next;
        }

        # based on where the tree is, look left...
        my @trees_left;
        for my $tree (@{$tree_grid[$i]}[0 .. $j -1]) {
            push(@trees_left, $tree);
        }
        my $visible_left = (! grep { $current_tree <= $_ } @trees_left);
        if ($visible_left) {
            $trees_visible++;
            next;
        }

        # same but look right...
        my @trees_right;
        for my $tree (@{$tree_grid[$i]}[$j + 1 .. $grid_width - 1]) {
            push(@trees_right, $tree);
        }
        my $visible_right = (! grep { $current_tree <= $_ } @trees_right);
        if ($visible_right) {
            $trees_visible++;
            next;
        }

        # same but look up...
        my @trees_up;
        for my $tree (map {$tree_grid[$_][$j]} 0 .. $i - 1) {
            push(@trees_up, $tree);
        }
        my $visible_up = (! grep { $current_tree <= $_ } @trees_up);
        if ($visible_up) {
            $trees_visible++;
            next;
        }

        # same but look down...
        my @trees_down;
        for my $tree (map {$tree_grid[$_][$j]} $i + 1 .. $grid_height - 1) {
            push(@trees_down, $tree);
        }
        my $visible_down = (! grep { $current_tree <= $_ } @trees_down);
        if ($visible_down) {
            $trees_visible++;
            next;
        }  
    }
}

print "SOLUTION 1: $trees_visible\n";

#print "\n\n\n";
#print $grid_height, "\n";
#print $grid_width, "\n";
