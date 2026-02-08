#!/usr/bin/env perl

use strict;
use warnings;
#use Test::More tests => 6;
use Test::More qw(no_plan);
use lib './lib';
use Weather;

my $weather = Weather->new(time => '2026-01-01');

is($weather->time, "2026-01-01", "Time can be set manually to 2026-01-01");

my $moonTest = <<'END';
                  ------------.
               -'  o     . .   `--.
            '   .    O   .       . `-.
          @   @@@@@@@   .  @@@@@      `-.
         @  @@@@@@@@@@@   @@@@@@@   .    \
          o @@@@@@@@@@@   @@@@@@@       . \.
        o   @@@@@@@@@@@.   @@@@@@@   O      \
      @   .   @@@@@@@o    @@@@@@@@@@     @@@ \
      @@               . @@@@@@@@@@@@@ o @@@@|
     @@  O  `.-./  .      @@@@@@@@@@@@    @@  \         First Quarter +
     @@    --`-'       o     @@@@@@@@ @@@@    |         4  3:49:21
     @@        `    o      .  @@   . @@@@@@@  |         Full Moon -
         @@  @         .-.     @@@   @@@@@@@  |         2 11:04:15
      @        @@@     `-'   . @@@@   @@@@  o /
         @@   @@@@@ .           @@   .       |
        @@@@  @\@@    /  .  O    .     o   . /
         @@     \ \  /         .    .       /
           .    .\.-.___   .      .   .-. /'
                  `-'                `-' /
             o   / |     o    O   .   .-'
            .   /     .       .    .-'
               -.       .      .--'
                  ------------'


END

is($weather->moon, $moonTest, "Get moon phase for 2026-01-01");

1;
