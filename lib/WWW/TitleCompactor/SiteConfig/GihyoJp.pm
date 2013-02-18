package WWW::TitleCompactor::SiteConfig::GihyoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/(?:gihyo\.jp|エンジニアマインド) … 技術評論社/);
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(qr/｜| \| /);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/連載/);
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_prefix_delimiter('：');
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/[^：]+/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(qr/：(?=第|\d)|(?<=ニュース)：/);
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->series_number(qr/第\d+回|.+?\d+日|.+?号/);
__PACKAGE__->series_number_prefix(1);
__PACKAGE__->series_number_prefix_delimiter(qr/\x{3000}/);
__PACKAGE__->series_number_suffix(0);
__PACKAGE__->series_number_suffix_delimiter(undef);
__PACKAGE__->series_number_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
