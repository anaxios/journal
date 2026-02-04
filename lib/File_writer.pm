package File_writer;

use Moose;
use namespace::autoclean;

has path => (
    is => 'ro',
    required => 1
);

sub write {
    my ($self, $content) = @_;
    #print $self->path;
    open(my $fh, '>', $self->path) or die $!;
    print $fh, $content;
    close($fh);
}

__PACKAGE__->meta->make_immutable;
