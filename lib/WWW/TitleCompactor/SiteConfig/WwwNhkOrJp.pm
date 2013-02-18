package WWW::TitleCompactor::SiteConfig::WwwNhkOrJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('NHKオンライン「ラボブログ」:NHKブログ');
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_prefix_delimiter(' | ');
__PACKAGE__->sitename_suffix_delimiter(undef);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category('お知らせ');
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_prefix_delimiter(' | ');
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
