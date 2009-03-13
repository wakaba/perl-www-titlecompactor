package Hatena::TitleCompactor::SiteConfig::BuilderJapanZdnetCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('builder by ZDNet Japan');

__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->author(qr/[\w\x{3000}]+/);
__PACKAGE__->author_prefix(0);
__PACKAGE__->author_prefix_delimiter(undef);
__PACKAGE__->author_suffix(1);
__PACKAGE__->author_suffix_delimiter(' - ');
__PACKAGE__->author_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
