package HtmlBuilder;

use Moose;
use FileReader;
use namespace::autoclean;

has _partial_dir => (
    is => 'ro',
    isa => 'Str',
    default => sub {
       return "./partials";
    }
);

has content =>  (
    is => 'rw',
    default => sub {return ""}
);

# TODO make interface consistant. header & footer take files while body Str.
sub header {
    my ($self, $tmp) = @_;
    $tmp = $self->_partial_dir . "/header.html";

    my $reader = FileReader->new(file => $tmp);
    $self->{content} = $self->{content} . $reader->read;

    return $self;
}

sub body {
    my ($self, $tmp) = @_;

    $self->{content} = $self->{content} . $tmp . "\n";

    return $self;
}

sub footer {
    my ($self, $tmp) = @_;
    $tmp = $self->_partial_dir . "/footer.html";

    my $reader = FileReader->new(file => $tmp);
    $self->{content} = $self->{content} . $reader->read;

    return $self;
}

sub build {
    my $self = shift;
    return $self->content;
}

__PACKAGE__->meta->make_immutable;
