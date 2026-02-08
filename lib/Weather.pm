package Weather;

use Moose;
use Time;
use HTTP::Tiny;
use namespace::autoclean;

has location => (
    is => 'ro',
    default => sub {
        my $self = shift;
        return $ENV{INTERSTITIAL_JOURNAL_LOCATION} || "Nashville";
    }
);

has time => (
    is => 'ro',
    default => sub {
        my ($self, $today) = @_;
        my $time = Time->new;

        return $time->today if ! $today;
        return $today;
    }
);

has moon => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        my $time = $self->time;
        my $http = HTTP::Tiny->new(agent => 'curl' );
        my $r = $http->get('http://wttr.in/Moon@' . $time . '?T');

        if ($r->{success}) {
            my $tmp = $r->{content};
            $tmp =~ s/Follow \@igor_chubin for wttr\.in updates\n?//g;
            return $tmp;
        } else {
            die "Failed to get weather: $r->{status} $r->{reason}";
        }
    }
);

has current => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        my $location = $self->location;
        my $http = HTTP::Tiny->new(agent => 'curl' );
        my $r = $http->get("http://wttr.in/$location?0?u?Q?T");

        if ($r->{success}) {
            return $r->{content};
        } else {
            die "Failed to get weather: $r->{status} $r->{reason}";
        }
    }
);

__PACKAGE__->meta->make_immutable;
