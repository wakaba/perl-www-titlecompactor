package WWW::TitleCompactor::SiteConfig::WwwComputerworldJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('Computerworld.jp');
__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_prefix_delimiter(undef);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/ソフトウェア＆サービス|［e・Gov］電子行政／電子政策|セキュリティ|セキュリティ・マネジメント/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix_delimiter(' : ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/[\w［］]+/);
__PACKAGE__->series_prefix(0);
__PACKAGE__->series_suffix(1);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix_delimiter(' : ');
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
