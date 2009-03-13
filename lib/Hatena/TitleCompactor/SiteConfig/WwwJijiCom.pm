package Hatena::TitleCompactor::SiteConfig::WwwJijiCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('時事ドットコム');
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_prefix_delimiter('：');
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->garbage('指定記事');
__PACKAGE__->garbage_prefix(0);
__PACKAGE__->garbage_prefix_delimiter(undef);
__PACKAGE__->garbage_suffix(1);
__PACKAGE__->garbage_suffix_delimiter('');
__PACKAGE__->garbage_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
