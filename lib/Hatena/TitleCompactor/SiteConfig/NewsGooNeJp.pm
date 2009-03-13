package Hatena::TitleCompactor::SiteConfig::NewsGooNeJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('goo ニュース');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2(qr/[^()]+?(?:ニュース|タイムズ|新聞|通信)|Voice|WIRED VISION|ファクタ|夕刊フジ|ダイヤモンド・オンライン|GLOBIS\.JP|日経.+|goo.+/);
__PACKAGE__->sitename2_prefix(0);
__PACKAGE__->sitename2_prefix_delimiter(undef);
__PACKAGE__->sitename2_suffix(1);
__PACKAGE__->sitename2_suffix_delimiter(undef);
__PACKAGE__->sitename2_bracket('(', ')');

__PACKAGE__->series(qr/[^＜＞【】]+/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(1);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket(qr/[【＜]/, qr/[】＞]/);

__PACKAGE__->category2(qr/\w+/);
__PACKAGE__->category2_prefix(0);
__PACKAGE__->category2_prefix_delimiter(undef);
__PACKAGE__->category2_suffix(1);
__PACKAGE__->category2_suffix_delimiter('――フィナンシャル･タイムズ');
__PACKAGE__->category2_bracket(undef, undef);

# sitename2 と重複しているので除去
__PACKAGE__->garbage('――フィナンシャル・タイムズ');
__PACKAGE__->garbage_prefix(0);
__PACKAGE__->garbage_prefix_delimiter(undef);
__PACKAGE__->garbage_suffix(1);
__PACKAGE__->garbage_suffix_delimiter(undef);
__PACKAGE__->garbage_bracket(undef, undef);

__PACKAGE__->page2(qr/\d+|上|下/);

__PACKAGE__->generate_pattern;

1;
