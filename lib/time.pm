package Time;

use strict;
use warnings;
use Time::Piece;

sub new {
    my ($class) = @_;

    my $self;

    bless $self, $class;

    return $self;

}

sub today {
    return localtime->strftime('%Y-%m-%d');
}

sub now {
    return localtime->strftime('%H-%M-%S');
}

1;
