package WWW::TitleCompactor::SiteConfig::MainichiJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('毎日ｊｐ(毎日新聞)');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2(qr/まんたんウェブ/);
__PACKAGE__->sitename2_prefix(0);
__PACKAGE__->sitename2_prefix_delimiter(undef);
__PACKAGE__->sitename2_suffix(1);
__PACKAGE__->sitename2_suffix_delimiter(undef);
__PACKAGE__->sitename2_bracket('(', ')');

__PACKAGE__->category(qr/映画インタビュー/);
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_prefix_delimiter('：');
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
