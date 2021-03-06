package WWW::TitleCompactor::SiteConfig::WwwZakzakCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/ZAKZAK/);
__PACKAGE__->sitename_prefix_delimiter(qr/[:：]|\s*-\s*|\s*/);
__PACKAGE__->sitename_suffix_delimiter(qr/[:：]|\s*-\s*|\s*/);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/芸能|社会/);
__PACKAGE__->category_prefix_delimiter(qr/[:：]|\s*-\s*|\s*/);
__PACKAGE__->category_suffix_delimiter(qr/[:：]|\s*-\s*|\s*/);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/芸能ニュース舞台裏/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(1);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket('【', '】');

__PACKAGE__->generate_pattern;

1;
