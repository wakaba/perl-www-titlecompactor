package Hatena::TitleCompactor::SiteConfig::NewsLivedoorCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/livedoor (?:ニュース|スポーツ)/);

__PACKAGE__->sitename_prefix_delimiter(' - ');
__PACKAGE__->sitename_suffix_delimiter(qr/ -? /);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/[^【】]+/);
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket('【', '】');

__PACKAGE__->generate_pattern;

1;
