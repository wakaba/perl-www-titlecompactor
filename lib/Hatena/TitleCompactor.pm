package Hatena::TitleCompactor;
use strict;
use warnings;
use base qw(Class::Accessor::Fast Class::Data::Inheritable);

use List::Rubyish;
use URI;
use UNIVERSAL::require;

require Hatena::TitleCompactor::SiteConfig;

__PACKAGE__->mk_accessors(qw(
    siteconfigs
),

# CAPTURABLE_FIELDS
qw(
    category
    series
    series_number
    author
));

sub new {
    my $self = shift->SUPER::new(@_);
    $self->siteconfigs({});
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

    warn $submodule;
    
    
    $self->siteconfigs->{$host} = $module;
}

sub compact_title {
    my ($self, $url, $title) = @_;
    $url = URI->new($url);
    # XXX: Don't use URI
    
    my $host = $url->can('host') ? $url->host : undef;
    # XXX: decode percent-encoding? case-sensitivity? trailing "."?
    
    $self->load_siteconfig($host);

    # CAPTURABLE_FIELDS
    $self->category(List::Rubyish->new);
    $self->series(List::Rubyish->new);
    $self->series_number(List::Rubyish->new);
    $self->author(List::Rubyish->new);
    
    return $self->siteconfigs->{$host}->compact_title($self, $title);
}

1;
