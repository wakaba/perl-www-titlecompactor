package WWW::TitleCompactor::SiteConfig::WwwForestImpressCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('窓の杜');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(' - ');
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_suffix_delimiter(undef);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/REVIEW|NEWS|特集/);
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket('【', '】');

__PACKAGE__->series(qr/\w+/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket('【', '】');

__PACKAGE__->series_number(qr/第\d+回|[前後]編/);
__PACKAGE__->series_number_prefix(1);
__PACKAGE__->series_number_prefix_delimiter('：');
__PACKAGE__->series_number_suffix(1);
__PACKAGE__->series_number_suffix_delimiter(qr/\s+/);
__PACKAGE__->series_number_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
