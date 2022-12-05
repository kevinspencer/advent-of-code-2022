#!/usr/bin/env perl

use List::Compare;
use strict;
use warnings;

my $file = 'dayfour-input.txt';
open(my $fh, '<', $file) || die "Could not open $file - $!\n";

my $subset_counter  = 0;
my $overlap_counter = 0;
while(<$fh>) {
    chomp;
    my ($first_tasks, $second_tasks) = split(/,/, $_);

    my ($first_start_task, $first_end_task) = split(/-/, $first_tasks);
    my @first_elf_task_range = ($first_start_task .. $first_end_task);

    my ($second_start_task, $second_end_task) = split(/-/, $second_tasks);
    my @second_elf_task_range = ($second_start_task .. $second_end_task);

    my $lc = List::Compare->new(\@first_elf_task_range, \@second_elf_task_range);    

    if (($lc->is_LsubsetR()) || ($lc->is_RsubsetL())) {
        $subset_counter++;
    }

    if (! $lc->is_LdisjointR()) {
        $overlap_counter++;
    }
}
close($fh);

print "Subsets:  $subset_counter\n";
print "Overlaps: $overlap_counter\n";
