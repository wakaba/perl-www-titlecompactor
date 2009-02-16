package Hatena::TitleCompactor::SiteConfig::WwwComputerworldJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('Computerworld.jp');

__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(undef);

__PACKAGE__->generate_pattern;

1;
