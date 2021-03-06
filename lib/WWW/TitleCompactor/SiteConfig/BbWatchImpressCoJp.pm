package WWW::TitleCompactor::SiteConfig::BbWatchImpressCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter(undef);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->sitename2_prefix(0);
__PACKAGE__->sitename2_suffix(0);
__PACKAGE__->sitename2_prefix_delimiter(undef);
__PACKAGE__->sitename2_suffix_delimiter(undef);
__PACKAGE__->sitename2_bracket(undef, undef);

__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
