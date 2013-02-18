package WWW::TitleCompactor::SiteConfig::WwwSanspoCom;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('SANSPO.COM');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2('サンケイスポーツ');
__PACKAGE__->sitename2_prefix(0);
__PACKAGE__->sitename2_prefix_delimiter(undef);
__PACKAGE__->sitename2_suffix(1);
__PACKAGE__->sitename2_suffix_delimiter('');
__PACKAGE__->sitename2_bracket('(', ')');

__PACKAGE__->category(qr/..|サッカー|コラム/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(' - ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series('甘口辛口');
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket('【', '】');

__PACKAGE__->page(qr{[0-9]+/[0-9]+ページ|[0-9]+});
__PACKAGE__->page_prefix(0);
__PACKAGE__->page_prefix_delimiter(undef);
__PACKAGE__->page_suffix(1);
__PACKAGE__->page_suffix_delimiter(' ');
__PACKAGE__->page_bracket(qr/(?:\(|（)/, qr/(?:\)|）)/);

__PACKAGE__->generate_pattern;

1;
