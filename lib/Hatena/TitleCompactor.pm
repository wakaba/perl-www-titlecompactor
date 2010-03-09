package Hatena::TitleCompactor;
use strict;
use warnings;
use base qw(Class::Accessor::Fast Class::Data::Inheritable);
use List::Rubyish;
use UNIVERSAL::require;

require Hatena::TitleCompactor::SiteConfig;

__PACKAGE__->mk_accessors(qw(
    siteconfigs
    host_checker
),

# CAPTURABLE_FIELDS
qw(
    category
    series
    series_number
    author
));

sub new {
    my $self = shift->SUPER::new({
        siteconfigs => {},
        host_checker => sub { 1 },
        @_ ? %{$_[0]} : (),
    });
    return $self;
}

sub load_siteconfig {
    my ($self, $host) = @_;
    $host = '' unless defined $host;
    return if $self->siteconfigs->{$host};

    my $hostclass = $host;
    $hostclass =~ s/(?:^|\.|-)(.)/uc $1/ge;

    my $module = join '::', __PACKAGE__, 'SiteConfig';
    
    my $submodule = $module . '::' . $hostclass;
    
    ($submodule->require and $module = $submodule)
        or ($@ =~ /in \@INC/ or warn $@);
    
    $self->siteconfigs->{$host} = $module;
}

sub compact_title {
    my ($self, $url, $title) = @_;

    my $host = '';
    if ($url =~ m[^[^:/?#]+://([^/?#]+)]) {
        $host = $1;
        $host =~ s/^[^\@]*\@//; # userinfo
        $host =~ s/:[^:]*$//; # port
        $host =~ tr/A-Z/a-z/; # ASCII case-insensitive
        $host =~ s/\.$//;
        # XXX: decode percent-encoding? punycode?
    }

    $self->host_checker->($host) or return $title;
    
    $self->load_siteconfig($host);

    # CAPTURABLE_FIELDS
    $self->category(List::Rubyish->new);
    $self->series(List::Rubyish->new);
    $self->series_number(List::Rubyish->new);
    $self->author(List::Rubyish->new);
    
    return $self->siteconfigs->{$host}->compact_title($self, $title);
}

1;
