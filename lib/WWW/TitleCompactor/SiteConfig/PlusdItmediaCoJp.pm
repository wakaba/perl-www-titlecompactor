package WWW::TitleCompactor::SiteConfig::PlusdItmediaCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/ITmedia \+D [\w\s]+/);
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->series('App Town 天気');
__PACKAGE__->series_prefix(1);
__PACKAGE__->series_prefix_delimiter('：');
__PACKAGE__->series_suffix(0);
__PACKAGE__->series_suffix_delimiter(undef);
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
