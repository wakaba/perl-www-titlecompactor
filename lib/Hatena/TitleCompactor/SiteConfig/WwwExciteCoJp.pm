package Hatena::TitleCompactor::SiteConfig::WwwExciteCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/Excite エキサイト|Excite|エキサイト(?:ニュース|イズム| ウェブアド タイムス)/);
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(' | ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(qr/ [:|] /);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
