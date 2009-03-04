package Hatena::TitleCompactor::SiteConfig::WwwItmediaCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/ITmedia [^-:：]+/);

__PACKAGE__->sitename_prefix_delimiter(qr/[:：]/);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
