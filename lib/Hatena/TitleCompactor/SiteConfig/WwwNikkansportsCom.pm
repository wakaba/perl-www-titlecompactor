package Hatena::TitleCompactor::SiteConfig::WwwNikkansportsCom;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('nikkansports.com');
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter(qr/ [:-] /);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\w+ニュース|プロ野球 オープン戦情報/);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(qr/ [>-] /);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
