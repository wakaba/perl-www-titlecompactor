package Hatena::TitleCompactor::SiteConfig::JapanZdnetCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('ZDNet Japan');

__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
