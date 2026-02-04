#!/usr/bin/env perl

use strict;
use warnings;
#use Test::More tests => 6;
use Test::More qw(no_plan);
use lib './lib';
use Time;
use Page;
use Journal;


my $time = Time->new;
my $today = $time->today;
like($today, qr/\d{4}-\d{2}-\d{2}/, 'Date format is YYYY-MM-DD');

my $now= $time->now;
like($now, qr/\d{2}-\d{2}-\d{2}/, 'Time format is hh-mm-ss');


# test Page
#my $journal_dir = 'interstitial_journal';
#my $journal_file = "$journal_dir/2025-12-24.md";
my $journal_file = "./t/test.md";

my $page = Page->new(file => "$journal_file");

ok(length($page->md), 'page source file is not empty');

is($page->convert, "<h2 id=\"test\">test</h2>\n\n<p>This is a test</p>\n", 'returns html from md');

# test Journal
my $journal = Journal->new(dir => './t');

ok(length($journal->entries), "Journal dir not empty");

my $entries = $journal->entries;
is($entries->[0]->file, 'test.md', "Create Pages with correct filenames");
