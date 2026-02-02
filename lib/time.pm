package Time;

use Moose;
use Time::Piece;
use namespace::autoclean;

has today => (
    is => 'rw',
    default => sub {localtime->strftime('%Y-%m-%d')}
);


has now => (
    is => 'ro',
    lazy => 1,
    default => sub {localtime->strftime('%H-%M-%S')}

);

__PACKAGE__->meta->make_immutable();
