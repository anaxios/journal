package Journal;

use Moose;
use namespace::autoclean;
use Page;

has dir => (
    is => 'ro',
    default => sub { $ENV{INTERSTITIAL_JOURNAL} || './interstitial_journal' }
);

has entries => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy => 1,
    builder => '_collate_pages'
);

sub _collate_pages {
    my $self = shift;

    opendir(my $dh, $self->{dir}) or die $!;
    my @files = grep {/\.md$/} readdir($dh);
    closedir($dh);

    my @pages = map {Page->new(file => $_)} @files;
    return \@pages;
}

sub publish {
    my $self = shift;

    foreach my $page ($self->entries->@*) {
        $page->convert;
    }
}

__PACKAGE__->meta->make_immutable;
