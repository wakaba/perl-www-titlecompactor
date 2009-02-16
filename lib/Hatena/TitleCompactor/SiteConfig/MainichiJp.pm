package Hatena::TitleCompactor::SiteConfig::MainichiJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('毎日ｊｐ(毎日新聞)');

__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(undef);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
