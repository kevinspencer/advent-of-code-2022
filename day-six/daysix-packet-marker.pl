#!/usr/bin/env perl

use strict;
use warnings;

my $marker_position = shift;

die "Need a marker position!\n" if ((! $marker_position) || ($marker_position !~ /\d+/));

open(my $fh, '<', 'daysix-input.txt') || die "Could not open daysix-input.txt - $!\n";
my $string = <$fh>;
close($fh);

my @tracking_chars;
my $char_position = 0;
for my $char (split//, $string) {
    $char_position++;
    push(@tracking_chars, $char);
    if (@tracking_chars == $marker_position) {
        # convert the array element values into hash keys and uniq them
        my $unique = { map { $_ => 1 } @tracking_chars };
        # if our unique count doesn't match our $marker_position, keep going
        if ($unique && (keys %$unique == $marker_position)) {
            print "Found unique at marker: $char_position\n";
            last;
        }
        shift(@tracking_chars);
    }
}
