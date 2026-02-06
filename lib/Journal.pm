package Journal;

use Moose;
use Page;
use HtmlBuilder;
use FileWriter;
#use File::Copy;
use File::Copy::Recursive qw(dircopy);
use namespace::autoclean;

has dir => (
    is => 'ro',
    default => sub { $ENV{INTERSTITIAL_JOURNAL} || './interstitial_journal' }
);

has source_dir => (
    is => 'ro',
    default => sub { $ENV{INTERSTITIAL_JOURNAL} || './interstitial_journal' }
);

has dest_dir => (
    is => 'ro',
    default => sub { $ENV{INTERSTITIAL_JOURNAL_HTML} || './_site' }
);

has entries => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy => 1,
    builder => '_build_entries'
);

sub _build_entries {
    my $self = shift;

    opendir(my $dh, $self->{dir}) or die $!;
    my @files = grep {/\.md$/} readdir($dh);
    closedir($dh);

    @files = sort { $b cmp $a } @files;
    my @pages = map {Page->new(file => $_)} @files;
    return \@pages;
}

sub _assets {
    my $self = shift;
    # TODO fix this weird error
    my $dest = "./_site"; #$self->dest_dir;
    dircopy("./assets", $dest) or die "Copy failed: $!";
}

sub publish {
    my $self = shift;

    my $html = HtmlBuilder->new;
    my @tmp;
    push(@tmp, "<div class=\"flow\">\n");
    foreach my $page ($self->entries->@*) {
        push(@tmp, "<div>\n" . $page->partial . "</div>");
    }
    push(@tmp, "</div>\n");
    $html
        ->header
        ->body(join("\n", @tmp))
        ->footer;

    _assets;
    my $writer = FileWriter->new(path => $self->dest_dir . "/" . "index.html");
    $writer->write($html->build);
}

__PACKAGE__->meta->make_immutable;
