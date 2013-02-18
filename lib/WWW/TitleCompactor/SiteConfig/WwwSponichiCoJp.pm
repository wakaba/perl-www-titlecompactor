package WWW::TitleCompactor::SiteConfig::WwwSponichiCoJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('スポニチ Sponichi Annex ニュース');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' ― ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/\w+/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(undef);
__PACKAGE__->category_bracket('（', '）');

__PACKAGE__->generate_pattern;

1;
