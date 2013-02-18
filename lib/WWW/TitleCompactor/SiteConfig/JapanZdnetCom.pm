package WWW::TitleCompactor::SiteConfig::JapanZdnetCom;
use strict;
use warnings;
use utf8;
use base qw(WWW::TitleCompactor::SiteConfig);

__PACKAGE__->sitename('ZDNet Japan');

__PACKAGE__->sitename_prefix(0);
__PACKAGE__->sitename_suffix_delimiter(' - ');
__PACKAGE__->sitename_bracket(undef, undef);

__PACKAGE__->category(qr/インタビュー|ソフトウェア?|インターネッ?ト?|OS／プラットフ?ォ?ー?ム?|企業情報|事例|ITマネジメント/);
__PACKAGE__->category_prefix(0);
__PACKAGE__->category_prefix_delimiter(undef);
__PACKAGE__->category_suffix(1);
__PACKAGE__->category_suffix_delimiter(' - ');
__PACKAGE__->category_bracket(undef, undef);

__PACKAGE__->series(qr/IT業界を生き抜く秘密10箇条?|The future of\.\.\.|\w+方|まだ間に|オール[\w・]+/);
__PACKAGE__->series_prefix(0);
__PACKAGE__->series_prefix_delimiter(undef);
__PACKAGE__->series_suffix(1);
__PACKAGE__->series_suffix_delimiter(' - ');
__PACKAGE__->series_bracket(undef, undef);

__PACKAGE__->garbage(' -');
__PACKAGE__->garbage_prefix(0);
__PACKAGE__->garbage_prefix_delimiter(undef);
__PACKAGE__->garbage_suffix(1);
__PACKAGE__->garbage_suffix_delimiter(undef);
__PACKAGE__->garbage_bracket(undef, undef);

__PACKAGE__->page(qr/前編|後編/);
__PACKAGE__->page_prefix(0);
__PACKAGE__->page_prefix_delimiter(undef);
__PACKAGE__->page_suffix(1);
__PACKAGE__->page_suffix_delimiter(undef);
__PACKAGE__->page_bracket('（', '）');

__PACKAGE__->page2(qr/page\d+/);
__PACKAGE__->page2_prefix(0);
__PACKAGE__->page2_prefix_delimiter(undef);
__PACKAGE__->page2_suffix(1);
__PACKAGE__->page2_suffix_delimiter(' - ');
__PACKAGE__->page2_bracket(undef, undef);

__PACKAGE__->generate_pattern;

1;
