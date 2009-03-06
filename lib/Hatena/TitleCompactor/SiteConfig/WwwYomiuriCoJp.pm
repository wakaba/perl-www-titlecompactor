package Hatena::TitleCompactor::SiteConfig::WwwYomiuriCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('YOMIURI ONLINE（読売新聞）');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(' : ');
__PACKAGE__->sitename_bracket(undef, undef);

#__PACKAGE__->category(qr/社会|特集|政治|科学|地域|島根|宇宙|国際/);
__PACKAGE__->category(qr/\w\w|ニュース|北海道|経済ニュース|マネー・経済|エンタメ|子ども|医療と介護|最前線|ネット＆デジタル|最新作紹介|ヘザーの映画館|家族・友人|人生案内/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(' : ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->page(qr/上|下/);
__PACKAGE__->page_prefix(1);
__PACKAGE__->page_prefix_delimiter(undef);
__PACKAGE__->page_suffix(0);
__PACKAGE__->page_suffix_delimiter(undef);
__PACKAGE__->page_bracket('（', '）');

__PACKAGE__->generate_pattern;

1;
