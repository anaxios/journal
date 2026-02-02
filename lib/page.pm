package Page;

use Moose;
use Text::MultiMarkdown 'markdown';
use namespace::autoclean;

has file => (
    is => 'ro'
);

has md => (
    is => 'ro',
    builder => '_read_file'
);

sub _read_file {
    my $self = shift;
    open(my $fh, '<', $self->{file}) or die $!;
    my $temp = do { local $/; <$fh> };
    close($fh);
    return $temp;
}

sub convert {
    my $self = shift;

    markdown($self->{md});
}

__PACKAGE__->meta->make_immutable;
