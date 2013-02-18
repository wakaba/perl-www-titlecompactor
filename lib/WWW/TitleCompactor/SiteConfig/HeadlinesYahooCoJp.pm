package WWW::TitleCompactor::SiteConfig::HeadlinesYahooCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('Yahoo!ニュース');

__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter('');
__PACKAGE__->category_bracket('（', '）');

__PACKAGE__->generate_pattern;

1;
