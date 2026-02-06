#!/usr/bin/env perl

use strict;
use warnings;
#use Test::More tests => 6;
use Test::More qw(no_plan);
use lib './lib';
use HtmlBuilder;

my $html = HtmlBuilder->new;
$html
    ->header
    ->body("<p>test</p>")
    ->footer;
my $temp = $html->build;
print $temp . "\n";

# TODO makes better tests. This test sucks.
ok(length($temp) > 0, "something");

1;
