package ReadFile;

use Moose;
use namespace::autoclean;

has file => (
    is => 'rw'
);

sub _read_file {
    my $self = shift;
    open(my $fh, '<', $self->{file}) or die $!;
    my $contents = do { local $/; <$fh> };
    close($fh);
    return $contents;
}

__PACKAGE__->meta->make_immutable;
