#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 3;  # or
#use Test::More qw(no_plan);
use lib '.';

require_ok('journal.pl');
Journal->import('today', 'now');

my $today = today();
like($today, qr/\d{4}-\d{2}-\d{2}/, 'Date format is YYYY-MM-DD');

my $now= now();
like($now, qr/\d{2}-\d{2}-\d{2}/, 'Time format is hh-mm-ss');
