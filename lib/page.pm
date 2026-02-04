package Page;

use Moose;
use Text::MultiMarkdown 'markdown';
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

has md => (
    is => 'ro',
    lazy => 1,
    builder => '_read_file'
);

sub _read_file {
    my $self = shift;
    open(my $fh, '<', $self->{source_dir} . "/" . $self->{file}) or die $!;
    my $temp = do { local $/; <$fh> };
    close($fh);
    return $temp;
}

sub convert {
    my $self = shift;

    markdown($self->md);
}

__PACKAGE__->meta->make_immutable;
