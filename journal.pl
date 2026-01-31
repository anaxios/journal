#!/usr/bin/env perl

package Journal;
use v5.10;
use strict;
use warnings;
use Time::Piece;

use feature 'say';

use Exporter 'import';
our @EXPORT_OK = qw(today now);

sub today {
    return localtime->strftime('%Y-$m-%d');
}

sub now {
    return localtime->strftime('%H-$M-%S');
}

sub edit_file {
    my $filename = shift;

    my $editor = $ENV{EDITOR} || $ENV{VISUAL} || "vim";

    system($editor, $filename);
}

# Only run main if running the script directly
main() unless caller();

sub main {
    edit_file "./test.md"
}


1;
