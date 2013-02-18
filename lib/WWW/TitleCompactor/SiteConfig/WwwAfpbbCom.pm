package WWW::TitleCompactor::SiteConfig::WwwAfpbbCom;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('AFPBB News');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter(' : ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\w+ニュース/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter('　');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->garbage(qr/写真\d+枚/);
__PACKAGE__->garbage_prefix(0);
__PACKAGE__->garbage_suffix(1);
__PACKAGE__->garbage_prefix_delimiter(undef);
__PACKAGE__->garbage_suffix_delimiter('　');
__PACKAGE__->garbage_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
