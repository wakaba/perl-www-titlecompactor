package WWW::TitleCompactor::SiteConfig::CareerzineJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/IT＆ウェブ業界の転職をサポートする「CAREERzine」（キャリアジン）/);
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_prefix_delimiter('：');
__PACKAGE__->sitename_suffix_delimiter('：');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
