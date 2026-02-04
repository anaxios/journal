package Role::Write_file;

use Moose::Role;
use namespace::autoclean;

has file => (
    is => 'ro'
);

sub _write_file {
    my ($self, $contents) = @_;
    open(my $fh, '>', $self->{file}) or die $!;
    #my $contents = do { local $/; <$fh> };
    close($fh);
}

__PACKAGE__->meta->make_immutable;
