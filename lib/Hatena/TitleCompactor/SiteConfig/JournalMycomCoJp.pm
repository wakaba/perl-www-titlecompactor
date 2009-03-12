package Hatena::TitleCompactor::SiteConfig::JournalMycomCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('マイコミジャーナル');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' | ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\w+/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(' | ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->category2(qr/レポート|連載|コラム|インタビュー|ハウツー|AIRコレ|レビュー/);
__PACKAGE__->category2_prefix(1);
__PACKAGE__->category2_prefix_delimiter(undef);
__PACKAGE__->category2_suffix(0);
__PACKAGE__->category2_suffix_delimiter(undef);
__PACKAGE__->category2_bracket('【', '】');

__PACKAGE__->page_prefix(0);
__PACKAGE__->page_prefix_delimiter(undef);
__PACKAGE__->page_suffix(0);
__PACKAGE__->page_suffix_delimiter(undef);

__PACKAGE__->generate_pattern;

1;
