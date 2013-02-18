package WWW::TitleCompactor::SiteConfig::ItNikkeiCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('IT-PLUS');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(':');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\[CNET Japan\] インターネット-最新ニュース/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix_delimiter('');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
