package WWW::TitleCompactor::SiteConfig::EnterprisezineJp;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename(qr/企業IT部門の変革を支援するエンタープライズ実践情報サイト EnterpriseZine|EnterpriseZine/);
__PACKAGE__->sitename_prefix(1);
__PACKAGE__->sitename_suffix(1);
__PACKAGE__->sitename_prefix_delimiter('：');
__PACKAGE__->sitename_suffix_delimiter('：');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
