package Page;

use Moose;
use Text::MultiMarkdown 'markdown';
use FileWriter;
use HtmlBuilder;
use namespace::autoclean;

has source_dir => (
    is => 'ro',
    default => sub { $ENV{INTERSTITIAL_JOURNAL} || './interstitial_journal' }
);

has dest_dir => (
    is => 'ro',
    default => sub { $ENV{INTERSTITIAL_JOURNAL_HTML} || './_site' }
);

has file => (
    is => 'ro',
    required => 1
);

#has writer => (
#    is => 'ro',
#    isa => 'Object',
#    lazy => 1,
#    default => sub {
#        my $self = shift;
#        my $t = $self->file;
#        $t =~ s/\.md$/.html/;
#        return FileWriter->new(path => $self->dest_dir . "/" . $t);
#    }
#);

has md => (
    is => 'ro',
    lazy => 1,
    builder => '_build_md'
);

has html => (
    is => 'rw',
    default => sub {
        HtmlBuilder->new;
    }
);

sub _build_md {
    my $self = shift;
    open(my $fh, '<', $self->{source_dir} . "/" . $self->{file}) or die $!;
    my $temp = do { local $/; <$fh> };
    close($fh);
    return $temp;
}

sub convert {
    my $self = shift;

   # my $t = markdown($self->md);
   # $self->writer->write($t);
   return markdown($self->md);
}

sub partial {
    my $self = shift;
    my $heading = $self->file;
    $heading =~ s/\.md$//;
    $self->html->body("<h1>" . $heading . "</h1>\n" . $self->convert);
    $self->html->build;
}

sub full {
    my $self = shift;
    my $heading = $self->file;
    $heading =~ s/\.md$//;
    $self->html
        ->header
        ->body("<h1>" . $heading . "</h1>\n" . $self->convert)
        ->footer;
    $self->html->build;
}

__PACKAGE__->meta->make_immutable;
