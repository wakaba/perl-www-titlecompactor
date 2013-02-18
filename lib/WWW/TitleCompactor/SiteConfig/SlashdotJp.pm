package WWW::TitleCompactor::SiteConfig::SlashdotJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/スラッシュドット[・\s]ジャパン|[^-]*?の日記/);

__PACKAGE__->sitename_prefix_delimiter(qr/ [|-] /);
__PACKAGE__->sitename_suffix_delimiter(qr/ [|-] /);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
