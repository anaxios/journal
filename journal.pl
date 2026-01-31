#!/usr/bin/env perl

package Journal;
use v5.10;
use strict;
use warnings;
use HTTP::Tiny;
use Time;

use feature 'say';

use Exporter 'import';
#our @EXPORT_OK = qw(today now);

sub edit_file {
    my $filename = shift;

    my $editor = $ENV{EDITOR} || $ENV{VISUAL} || "vim";

    system($editor, $filename);
}

sub append_current_time {
    my $filename = shift;
    open(my $fh, '>>', $filename) or die "Cannot open file: $!";
    my $t = Time->new;
    print $fh "\n## " . $t->now() . "\n";
    close($fh);
}

sub append_current_file {
    my $filename = shift;
    my $content = shift;
    open(my $fh, '>>', $filename) or die "Cannot open file: $!";
    print $fh $content . "\n";
    close($fh);
}

sub ascii_art_tag {
    my $c = shift;
    return "<pre class=\"ascii-art\">\n$c\n</pre>";
}

sub get_weather {
    my $location = shift;
    my $http = HTTP::Tiny->new(agent => 'curl' );
    my $r = $http->get("http://wttr.in/$location?0?u?Q?T");

    if ($r->{success}) {
        return $r->{content};
    } else {
        die "Failed to get weather: $r->{status} $r->{reason}";
    }
}

# Only run main if running the script directly
main() unless caller();

sub main {
    my $t = Time->new;
    my $location = $ENV{WTTR_LOCATION};
    my $journal_dir = 'interstitial_journal';
    my $filename = $journal_dir . '/' . $t->today() . ".md";

    if (! -d $journal_dir) {
        die "Cannot open directory $journal_dir/";
    }

    if (! -e $filename) {
        my $w = get_weather($location);
        append_current_file($filename, ascii_art_tag($w));
    }
    append_current_time($filename);
    edit_file($filename);
}


1;
