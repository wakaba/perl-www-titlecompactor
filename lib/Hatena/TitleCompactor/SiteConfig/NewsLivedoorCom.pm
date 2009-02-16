package Hatena::TitleCompactor::SiteConfig::NewsLivedoorCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('livedoor ニュース');

__PACKAGE__->sitename_prefix_delimiter(' - ');
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
