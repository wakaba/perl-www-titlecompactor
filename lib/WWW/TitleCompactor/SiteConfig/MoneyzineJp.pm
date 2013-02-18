package WWW::TitleCompactor::SiteConfig::MoneyzineJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('株／FX・投資と経済がよくわかるMONEYzine');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter('：');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
