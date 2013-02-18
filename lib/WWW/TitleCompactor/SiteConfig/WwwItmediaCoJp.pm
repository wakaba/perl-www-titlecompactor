package WWW::TitleCompactor::SiteConfig::WwwItmediaCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/ITmedia [^-:：]+/);

__PACKAGE__->sitename_prefix_delimiter(qr/[:：]/);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->series(qr/[^：]+/);
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter('：');
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
