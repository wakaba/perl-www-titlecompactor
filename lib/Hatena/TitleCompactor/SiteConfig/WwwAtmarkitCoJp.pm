package Hatena::TitleCompactor::SiteConfig::WwwAtmarkitCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/＠IT(?:情報マネジメント| Special PR)?/);
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_prefix_delimiter(qr/：\s*/);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(qr/\s*[-－−]\s*/);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category('連載');
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_prefix_delimiter('：');
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series_number(qr/\d+/);
__PACKAGE__->series_number_prefix(0);
__PACKAGE__->series_number_prefix_delimiter(undef);
__PACKAGE__->series_number_suffix(1);
__PACKAGE__->series_number_suffix_delimiter(undef);
__PACKAGE__->series_number_bracket('（', '）');

__PACKAGE__->generate_pattern;

1;
