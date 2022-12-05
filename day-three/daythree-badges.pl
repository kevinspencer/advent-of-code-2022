#!/usr/bin/env perl

use List::Compare;
use List::MoreUtils qw(firstidx);
use strict;
use warnings;

my $file = 'day-three-input.txt';
open(my $fh, '<', $file) || die "Could not open $file - $!\n";

my $priority_count = 0;

my @elf_group_badges;
while(<$fh>) {
    chomp;
    my $bag_contents_string = $_;

    push(@elf_group_badges, $bag_contents_string);

    if (@elf_group_badges == 3) {
        # split the string atoms...
        my @one   = split(//, $elf_group_badges[0]);
        my @two   = split(//, $elf_group_badges[1]);
        my @three = split(//, $elf_group_badges[2]);

        my $lc = List::Compare->new(\@one, \@two, \@three);

        my @intersection = $lc->get_intersection();

        $priority_count += get_score_for_char($intersection[0]);

        @elf_group_badges = ();
    }
}

close($fh);

print $priority_count, "\n";

sub get_score_for_char {
    my $char = shift;

    return 0 if (! $char);

    my @alphabet = qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);
    my $force_char_lowercase = lc($char);
    my $position = firstidx { /$force_char_lowercase/ } @alphabet;

    return ($char =~ /[A-Z]/) ? (27 + $position) : (1 + $position);
}
