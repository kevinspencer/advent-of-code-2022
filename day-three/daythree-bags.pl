#!/usr/bin/env perl

use List::Compare;
use List::MoreUtils qw(firstidx);
use strict;
use warnings;

my @alphabet = qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);

my $file = 'day-three-input.txt';
open(my $fh, '<', $file) || die "Could not open $file - $!\n";

my $priority_count = 0;

while(<$fh>) {
    chomp;
    my $bag_contents_string = $_;

    # split the string atoms...
    my @bag_contents_array = split(//, $bag_contents_string);

    # and now split the array in two, note $bag_contents_array now the "second half"
    my @bag_first_array = splice(@bag_contents_array, 0, (@bag_contents_array / 2));

    my $lc = List::Compare->new(\@bag_first_array, \@bag_contents_array);    

    my @intersection = $lc->get_intersection();

    $priority_count += get_score_for_char($intersection[0]);
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
