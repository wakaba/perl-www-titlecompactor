package WWW::TitleCompactor::SiteConfig::WwwAsahiCom;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/asahi.com(?:（朝日新聞社）)?/);
__PACKAGE__->sitename_prefix_delimiter(qr/[:：]/);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix_delimiter(' - ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->category2(qr/マイタウン\w+/);
__PACKAGE__->category2_prefix(0);
__PACKAGE__->category2_suffix(1);
__PACKAGE__->category2_suffix_delimiter(qr/-/);
__PACKAGE__->category2_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
