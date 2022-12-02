#!/usr/bin/env perl

use strict;
use warnings;

my $elf_counter = 1;
my %elf_buckets;
while(<>) {
    chomp;
    my $calorie_count = $_;
    if ($calorie_count !~ /\d+/) {
        $elf_counter++;
        next;
    }
    $elf_buckets{$elf_counter} += $calorie_count;
}

my $top_three_elf_calories = $elf_counter = 0;
for my $elf_calory_count (sort { $elf_buckets{$b} <=> $elf_buckets{$a} } keys %elf_buckets) {
    $top_three_elf_calories += $elf_buckets{$elf_calory_count};
    if (++$elf_counter == 3) {
        print $top_three_elf_calories, "\n";
        last;
    }
}
