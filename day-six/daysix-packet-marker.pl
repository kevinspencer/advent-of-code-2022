#!/usr/bin/env perl

use strict;
use warnings;

open(my $fh, '<', 'daysix-input.txt') || die "Could not open daysix-input.txt - $!\n";
my $string = <$fh>;
close($fh);

my @last_four_chars;
my $char_position = 0;
for my $char (split//, $string) {
    $char_position++;
    push(@last_four_chars, $char);
    if (@last_four_chars == 4) {
        my $unique = { map { $_ => 1 } @last_four_chars };
        if ($unique && (keys %$unique == 4)) {
            print "Found unique at marker: $char_position\n";
            exit();
        }
        shift(@last_four_chars);
    }
}
