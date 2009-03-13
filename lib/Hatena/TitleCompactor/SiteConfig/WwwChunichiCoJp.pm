package Hatena::TitleCompactor::SiteConfig::WwwChunichiCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/中日新聞|中日スポーツ/);
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_prefix_delimiter(':');
__PACKAGE__->sitename_suffix_delimiter(undef);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2(qr/CHUNICHI Web/);
__PACKAGE__->sitename2_prefix(0);
__PACKAGE__->sitename2_suffix(1);
__PACKAGE__->sitename2_prefix_delimiter(undef);
__PACKAGE__->sitename2_suffix_delimiter(undef);
__PACKAGE__->sitename2_bracket('(', ')');

__PACKAGE__->category(qr/..|ドラニュース|おすすめ/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(':');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series('中スポ　コンフィデンシャル');
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket('＜', '＞');

__PACKAGE__->generate_pattern;

1;
