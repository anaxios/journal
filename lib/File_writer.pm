package File_writer;

use Moose;
use namespace::autoclean;

has path => (
    is => 'ro',
    required => 1
);

sub write {
    my ($self, $content) = @_;
    open(my $fh, '>', $self->{path}) or die $!;
    print $fh, $content;
    close($fh);
}

__package__->meta->make_immutable;
