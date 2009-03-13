package Hatena::TitleCompactor::SiteConfig::BlogsItmediaCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/ITmedia [^-:：]+/);
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' : ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2(qr/[^>]+?/);
__PACKAGE__->sitename2_prefix(1);
__PACKAGE__->sitename2_prefix_delimiter(' > ');
__PACKAGE__->sitename2_suffix(0);
__PACKAGE__->sitename2_suffix_delimiter(undef);
__PACKAGE__->sitename2_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
