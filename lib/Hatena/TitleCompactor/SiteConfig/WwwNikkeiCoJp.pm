package Hatena::TitleCompactor::SiteConfig::WwwNikkeiCoJp;
use strict;
use warnings;
use utf8;
use base qw(Hatena::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/NIKKEI NET(?:（日経ネット）)?|日経ネット関西版/);
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_prefix_delimiter(qr/\s*(?:[-‐－|：:]\s*)?/);
__PACKAGE__->sitename_suffix_delimiter(qr/\s*(?:[-‐－|：:]\s*)?/);
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/..ニュース|NET EYE プロの視点|社説・春秋|各分野の重要ニュースを掲載|アメリカ、ＥＵ、アジアなど海外ニュースを速報|マクロ経済の動向から金融政策、業界の動きまでカバー|日本経済新聞の社説、1面コラムの春秋|社説./);
__PACKAGE__->category_prefix(1);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_prefix_delimiter(qr/\s*(?:[-‐−－|：:]\s*)?/);
__PACKAGE__->category_suffix_delimiter(qr/\s*(?:[-‐−－|：:]\s*)?/);
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->page_prefix(0);
__PACKAGE__->page_suffix(0);
__PACKAGE__->page_prefix_delimiter(undef);
__PACKAGE__->page_suffix_delimiter(undef);

__PACKAGE__->generate_pattern;

1;
