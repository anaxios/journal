package FileReader;

use Moose;
use namespace::autoclean;

has file => (
    is => 'rw'
);

sub read {
    my $self = shift;
    open(my $fh, '<', $self->{file}) or die $!;
    my $contents = do { local $/; <$fh> };
    close($fh);
    return $contents;
}

__PACKAGE__->meta->make_immutable;
