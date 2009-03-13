package Hatena::TitleCompactor::SiteConfig;
use strict;
use warnings;
use utf8;
use base qw(Class::Data::Inheritable);

for my $name (qw/
    sitename sitename2
    category category2
    page page2
    author
    garbage
/) {
    __PACKAGE__->mk_classdata($name);
    __PACKAGE__->mk_classdata($name.'_prefix_delimiter');
    __PACKAGE__->mk_classdata($name.'_suffix_delimiter');
    __PACKAGE__->mk_classdata($name.'_bracket_start');
    __PACKAGE__->mk_classdata($name.'_bracket_end');
    __PACKAGE__->mk_classdata($name.'_prefix');
    __PACKAGE__->mk_classdata($name.'_suffix');
    eval qq{
        sub ${name}_bracket {
            my \$class = shift;
            \$class->${name}_bracket_start(shift);
            \$class->${name}_bracket_end(shift);
        }
    };
}

__PACKAGE__->sitename(qr/[\w.-]+?/);
__PACKAGE__->sitename_prefix_delimiter(qr/\s*[|:：―‐-]\s*/); # XXX
__PACKAGE__->sitename_suffix_delimiter(qr/\s*[|:：―‐>-]\s*/); # XXX

__PACKAGE__->sitename2(qr/\w+?(?:新聞|ニュース|スポーツ)/);
__PACKAGE__->sitename2_prefix(1);
__PACKAGE__->sitename2_suffix(1);
__PACKAGE__->sitename2_bracket(qr/[(]/, qr/[)]/);

__PACKAGE__->category(qr/[\w.-]+?/);
__PACKAGE__->category_bracket(qr/[(（【]/, qr/[)）】]/);

__PACKAGE__->page(qr/その\s*\d+|\d+\/\d+ページ|page\d+/);
__PACKAGE__->page_prefix(1);
__PACKAGE__->page_suffix_delimiter(qr/(?: - )?/);
__PACKAGE__->page_bracket(qr/[(（【]?/, qr/[)）】]?/);

__PACKAGE__->page2(qr/\d+\/\d+/);
__PACKAGE__->page2_suffix(1);
__PACKAGE__->page2_suffix_delimiter(qr/(?: - )?/);
__PACKAGE__->page2_bracket(qr/[(（【]/, qr/[)）】]/);

__PACKAGE__->mk_classdata('prefix_pattern');
__PACKAGE__->mk_classdata('suffix_pattern');

__PACKAGE__->generate_pattern;

sub generate_regexp {
    my $class = shift;
    my $pattern = shift;
    
    if (not defined $pattern) {
        return undef;
    } elsif (ref $pattern) {
        return $pattern;
    } else {
        return quotemeta $pattern;
    }
}

sub generate_prefix_and_suffix {
    my ($class, $name) = @_;
    
    my $prefix;
    my $suffix;

    my $method = $name;
    my $body = $class->generate_regexp($class->$method);

    $method = $name . '_prefix_delimiter';
    my $pdelim = $class->generate_regexp($class->$method);

    $method = $name . '_suffix_delimiter';
    my $sdelim = $class->generate_regexp($class->$method);

    $method = $name . '_bracket_start';
    my $bstart = $class->generate_regexp($class->$method);

    $method = $name . '_bracket_end';
    my $bend = $class->generate_regexp($class->$method);
    
    $method = $name . '_prefix';
    my $as_prefix = $class->generate_regexp($class->$method);
    
    $method = $name . '_suffix';
    my $as_suffix = $class->generate_regexp($class->$method);

    if (defined $body) {
        if (defined $bstart and defined $bend) {
            $prefix = $bstart . $body . $bend;
            $suffix = $prefix;
        } else {
            $prefix = $body;
            $suffix = $prefix;
        }
        
        if (defined $prefix and defined $pdelim) {
            $prefix .= $pdelim;
        } elsif (not $as_prefix) {
            undef $prefix;
        }

        if (defined $suffix and defined $sdelim) {
            $suffix = $sdelim . $suffix;
        } elsif (not $as_suffix) {
            undef $suffix;
        }
    }

    return ($prefix, $suffix);
}

sub generate_pattern {
    my $class = shift;
    
    my @prefix = (qr/\s+/);
    my @suffix = (qr/\s+/);

    for my $name (qw/sitename sitename2 category category2 page page2 author garbage/) {
        my ($prefix, $suffix) = $class->generate_prefix_and_suffix($name);
        push @prefix, $prefix if defined $prefix;
        push @suffix, $suffix if defined $suffix;
    }
    
    my $prefix_pattern = sprintf '^(?:%s)', join '|', @prefix;
    my $suffix_pattern = sprintf '(?:%s)$', join '|', @suffix;
    # XXX: assemble

#warn $prefix_pattern;
warn $suffix_pattern;
    
    $class->prefix_pattern($prefix_pattern);
    $class->suffix_pattern($suffix_pattern);
}

sub compact_title {
    my ($class, $title) = @_;
    
    my $suffix_pattern = $class->suffix_pattern;
    1 while $title =~ s/$suffix_pattern//g;

    my $prefix_pattern = $class->prefix_pattern;
    1 while $title =~ s/$prefix_pattern//g;
    
    return $title;
}

1;
