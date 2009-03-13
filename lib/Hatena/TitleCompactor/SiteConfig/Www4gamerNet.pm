package Hatena::TitleCompactor::SiteConfig::Www4gamerNet;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('4Gamer.net');
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_prefix_delimiter(qr/\s*[-－―]\s*/);
__PACKAGE__->sitename_suffix_delimiter(undef);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2('4Gamer.net');
__PACKAGE__->sitename2_prefix(1);
__PACKAGE__->sitename2_suffix(0);
__PACKAGE__->sitename2_prefix_delimiter(qr/\s*[-－―]\s*/);
__PACKAGE__->sitename2_suffix_delimiter(undef);
__PACKAGE__->sitename2_bracket('【', '】');

__PACKAGE__->category('週刊連載');
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(qr/\s*[-－―]\s*/);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/.+?(?=第\d+回：)/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->series_number(qr/第\d+回/);
__PACKAGE__->series_number_prefix(1);
__PACKAGE__->series_number_prefix_delimiter('：');
__PACKAGE__->series_number_suffix(0);
__PACKAGE__->series_number_suffix_delimiter(undef);
__PACKAGE__->series_number_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
