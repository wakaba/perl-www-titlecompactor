package WWW::TitleCompactor::SiteConfig;
use strict;
use warnings;
use utf8;
use base qw(Class::Data::Inheritable);

use constant CAPTURABLE_FIELDS => qw(category series series_number author);

for my $name (qw/
    sitename sitename2
    category category2
    series series_number
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

__PACKAGE__->sitename(qr/(?!第)[\w.＠-]+?(?<!た)(?:（[\w.＠-]+）)?/);
__PACKAGE__->sitename_prefix_delimiter(qr/\s*[|:：―‐−-]\s*/);
__PACKAGE__->sitename_suffix_delimiter(qr/\s*[|:：―‐>−-]\s*/);

__PACKAGE__->sitename2(qr/\w+?(?:新聞|ニュース|スポーツ)/);
__PACKAGE__->sitename2_prefix(1);
__PACKAGE__->sitename2_suffix(1);
__PACKAGE__->sitename2_bracket(qr/\(/, qr/\)/);

__PACKAGE__->category(qr/[\w.-]+?/);
__PACKAGE__->category_bracket(qr/(?:\(|（|【)/, qr/(?:\)|）|】)/);

__PACKAGE__->page(qr/その\s*\d+|\d+\/\d+ページ|page\d+|前編|後編/);
__PACKAGE__->page_prefix(1);
__PACKAGE__->page_suffix_delimiter(qr/(?: - )?/);
__PACKAGE__->page_bracket(qr/(?:\(|（|【)?/, qr/(?:\)|）|】)?/);

__PACKAGE__->page2(qr/\d+\/\d+|上|下/);
__PACKAGE__->page2_suffix(1);
__PACKAGE__->page2_suffix_delimiter(qr/(?: - )?/);
__PACKAGE__->page2_bracket(qr/(?:\(|（|【)/, qr/(?:\)|）|】)/);

for (CAPTURABLE_FIELDS, 'other') {
    __PACKAGE__->mk_classdata($_.'_prefix_pattern');
    __PACKAGE__->mk_classdata($_.'_suffix_pattern');
}

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
    my ($class, $name, $capture) = @_;
    
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
        if ($capture) {
            $body = "($body)";
        }

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

    # Regexp::Assemble を使いたいけど文字クラスの構文解析に失敗するみたい

    {
        my @prefix = (qr/\s+/);
        my @suffix = (qr/\s+/);

        # Fields except for CAPTURABLE_FIELD related ones
        for my $name (qw/sitename sitename2 page page2 garbage/) {
            my ($prefix, $suffix) = $class->generate_prefix_and_suffix($name);
            push @prefix, $prefix if defined $prefix;
            push @suffix, $suffix if defined $suffix;
        }
        
        my $prefix_pattern = sprintf '^(?:%s)', join '|', @prefix;
        my $suffix_pattern = sprintf '(?:%s)$', join '|', @suffix;

#        require Regexp::Assemble;
##warn $class;        
#        my $r = Regexp::Assemble->new;
#        warn $_ for @suffix;
#        
#        $r->add($_) for @suffix;
#        warn $suffix_pattern;
#        
#        $suffix_pattern = '(?:' . $r->re . ')$';
#warn $suffix_pattern;        
        
        $class->other_prefix_pattern($prefix_pattern);
        $class->other_suffix_pattern($suffix_pattern);
    }

    for my $i (
        # CAPTURABLE_FIELDS
        [category => [qw/category category2/]],
        [series => [qw/series/]],
        [series_number => [qw/series_number/]],
        [author => [qw/author/]],
    ) {
        my @prefix;
        my @suffix;
        
        for my $name (@{$i->[1]}) {
            my ($prefix, $suffix) = $class->generate_prefix_and_suffix($name, 1);
            push @prefix, $prefix if defined $prefix;
            push @suffix, $suffix if defined $suffix;
        }
        
        my $prefix_pattern = @prefix ? sprintf '^(?:%s)', join '|', @prefix : '(?!)';
        my $suffix_pattern = @suffix ? sprintf '(?:%s)$', join '|', @suffix : '(?!)';

        my $pp = "$i->[0]_prefix_pattern";
        my $sp = "$i->[0]_suffix_pattern";
        $class->$pp($prefix_pattern);
        $class->$sp($suffix_pattern);
    }
}

sub compact_title {
    my ($class, $obj, $title) = @_;
    
    my $suffix_patterns = {};
    for (CAPTURABLE_FIELDS, 'other') {
        my $m = $_ . '_suffix_pattern';
        $suffix_patterns->{$_} = $class->$m;
    }
    
    {     
        my $matched = 0;
     
        $matched = 1 while $title =~ s/$suffix_patterns->{other}//g;
        
        for my $n (CAPTURABLE_FIELDS) {
            while ($title =~ s/$suffix_patterns->{$n}//) {
               $matched = 1;
               $obj->$n->push(defined $1 ? $1 : $2);
           }
        }
        
        redo if $matched;
    }
    
    my $prefix_patterns = {};
    for (CAPTURABLE_FIELDS, 'other') {
        my $m = $_ . '_prefix_pattern';
        $prefix_patterns->{$_} = $class->$m;
    }
    
    {     
        my $matched = 0;
     
        $matched = 1 while $title =~ s/$prefix_patterns->{other}//g;
        
        for my $n (CAPTURABLE_FIELDS) {
            while ($title =~ s/$prefix_patterns->{$n}//) {
                $matched = 1;
                $obj->$n->push(defined $1 ? $1 : $2);
            }
        }
        
        redo if $matched;
    }
    
    return $title;
}

1;
