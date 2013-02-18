package WWW::TitleCompactor::SiteConfig::WwwIzaNeJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('イザ！');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(qr/[：:]/);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\w+/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(qr/[：:]/);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/[\w・]+/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket('【', '】');

__PACKAGE__->series_number(qr/上|下/);
__PACKAGE__->series_number_prefix(1);
__PACKAGE__->series_number_prefix_delimiter(undef);
__PACKAGE__->series_number_suffix(0);
__PACKAGE__->series_number_suffix_delimiter(undef);
__PACKAGE__->series_number_bracket('（', '）');

__PACKAGE__->generate_pattern;

sub compact_title {
    my ($class, $obj, $title) = @_;
    
    $title = $class->SUPER::compact_title($obj, $title);

    if ($title =~ /^「/ and $title =~ /」$/) {
        $title =~ s/^「//;
        $title =~ s/」$//;
        
        shift;
        $title = $class->SUPER::compact_title($obj, $title);
    }
    
    return $title;
}

1;
