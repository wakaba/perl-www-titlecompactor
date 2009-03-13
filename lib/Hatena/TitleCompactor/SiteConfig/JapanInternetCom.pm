package Hatena::TitleCompactor::SiteConfig::JapanInternetCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_suffix_delimiter(undef);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\S+/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(' - japan.internet.com ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/[\w]+/);
__PACKAGE__->series_prefix(0);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(1);
__PACKAGE__->series_suffix_delimiter(' / ');
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
