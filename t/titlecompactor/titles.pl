#!/usr/bin/perl 
package Test::Hatena::TitleCompactor;
use strict;
use warnings;
use utf8;
use lib qw(lib);

use base qw(Test::Class);
use Test::More;

use Hatena::TitleCompactor;

sub prepare_data : Test(setup) {
    my $self = shift;

    $self->{data} = [];
    
    $self->{current_host} = 'www.foo.test';
    my $current_entry = {};
    
    while (<DATA>) {
        if (m[^//(.+)]) {
            $self->{current_host} = $1;
        } elsif (/\S/) {
            chomp;
            if (defined $current_entry->{input}) {
                $current_entry->{expected} = $_;
            } else {
                $current_entry->{input} = $_;
            }
        } else {
            if (defined $current_entry->{input}) {
                $self->_add_data($current_entry);
                $current_entry = {};
            }
        }
    }

    if (defined $current_entry->{input}) {
        $self->_add_data($current_entry);
    }
}

sub _add_data {
    my $self = shift;
    my $entry = shift;

    $entry->{host} = $self->{current_host} unless defined $entry->{host};
    
    push @{$self->{data}}, $entry;
}

sub test : Tests {
    my $self = shift;
    
    my $te = Hatena::TitleCompactor->new;
    
    for my $entry (@{$self->{data}}) {
        my $url = $entry->{url};
        $url = 'http://' . $entry->{host} unless defined $url;
        
        my $result = $te->compact_title($url, $entry->{input});
        is $result, $entry->{expected};
    }
}

__PACKAGE__->runtests;

1;

__DATA__

//example.com

example - example.com
example

//www.asahi.com

asahi.com（朝日新聞社）：ダル・岩隈・松坂そろって順調　ＷＢＣ合宿シート打撃 - スポーツ
ダル・岩隈・松坂そろって順調　ＷＢＣ合宿シート打撃

asahi.com（朝日新聞社）：小室被告初公判、５億円詐欺認める　弁償はめど立たず - 社会
小室被告初公判、５億円詐欺認める　弁償はめど立たず

//mainichi.jp

篤姫：最終回の視聴率は２８．７％　平均視聴率は過去１０年で最高 - 毎日ｊｐ(毎日新聞)
篤姫：最終回の視聴率は２８．７％　平均視聴率は過去１０年で最高

タイ：映画「闇の子供たち」、バンコク映画祭で上映中止 - 毎日ｊｐ(毎日新聞)
タイ：映画「闇の子供たち」、バンコク映画祭で上映中止

映画インタビュー：「闇の子供たち」阪本順治監督に聞く　「日本人にはね返ってくる映画にしたかった」 - 毎日ｊｐ(毎日新聞)
映画インタビュー：「闇の子供たち」阪本順治監督に聞く　「日本人にはね返ってくる映画にしたかった」

ワンダーフェスティバル：エスカレーター事故で中止の模型イベント 幕張メッセで７月再開へ(まんたんウェブ) - 毎日ｊｐ(毎日新聞)
ワンダーフェスティバル：エスカレーター事故で中止の模型イベント 幕張メッセで７月再開へ

//headlines.yahoo.co.jp

ミニスカ美脚の宮崎あおい「ガッチガチに浣腸してます」との言い間違いを大爆笑!!（シネマトゥデイ） - Yahoo!ニュース
ミニスカ美脚の宮崎あおい「ガッチガチに浣腸してます」との言い間違いを大爆笑!!

＜ハロープロジェクト＞安倍なつみ、中澤裕子、松浦亜弥ら大量25人が来年3月卒業へ（毎日新聞） - Yahoo!ニュース
＜ハロープロジェクト＞安倍なつみ、中澤裕子、松浦亜弥ら大量25人が来年3月卒業へ

//www.nikkansports.com
宮崎あおい「好きだ、」４年がかり公開 - nikkansports.com > 芸能ニュース
宮崎あおい「好きだ、」４年がかり公開

宮崎あおい「初恋」が初日 - シネマニュース : nikkansports.com
宮崎あおい「初恋」が初日

//www.sanspo.com

元モー娘。、松浦亜弥ら来年３月でハロプロ卒業(サンケイスポーツ)
元モー娘。、松浦亜弥ら来年３月でハロプロ卒業

//www.excite.co.jp

“押米”から９年ぶり！米米ＣＬＵＢが７カ月限定の再結成 | Excite エキサイト : ニュース
“押米”から９年ぶり！米米ＣＬＵＢが７カ月限定の再結成

//www.itmedia.co.jp

ITIL Managerの視点から：初めてのサービスレベルアグリーメント【その2】 - ITmedia エンタープライズ
ITIL Managerの視点から：初めてのサービスレベルアグリーメント

ITIL Managerの視点から：初めてのサービスレベルアグリーメント【その3】 (1/2) 
ITIL Managerの視点から：初めてのサービスレベルアグリーメント

“世界初”トリプルエンジン搭載　TraceMonkey採用の「Lunascape 5.0α」 - ITmedia Biz.ID
“世界初”トリプルエンジン搭載　TraceMonkey採用の「Lunascape 5.0α」

IT Oasis：マニュアルを精読する人、まずスイッチをいれる人――新「気質分類」 (2/2) - ITmedia エンタープライズ
IT Oasis：マニュアルを精読する人、まずスイッチをいれる人――新「気質分類」

//plusd.itmedia.co.jp

NHKオンライン、Wii向け「NHKニュース」を提供開始 - ITmedia +D Games
NHKオンライン、Wii向け「NHKニュース」を提供開始

//builder.japan.zdnet.com

グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ - builder by ZDNet Japan
グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ

//japan.zdnet.com

グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ - インターネ - page2 - ZDNet Japan
グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ - インターネ

//codezine.jp

「Lunascape 5.0」アルファ版リリース、　世界最速JavaScriptエンジン「TraceMonkey」を搭載：CodeZine
「Lunascape 5.0」アルファ版リリース、　世界最速JavaScriptエンジン「TraceMonkey」を搭載

//journal.mycom.co.jp

Lunascape、世界最速JavaScriptエンジンとトリプルエンジン搭載のブラウザ | パソコン | マイコミジャーナル
Lunascape、世界最速JavaScriptエンジンとトリプルエンジン搭載のブラウザ

Google、Gmailに音声/ビデオチャット機能を追加 | ネット | マイコミジャーナル
Google、Gmailに音声/ビデオチャット機能を追加

//www.computerworld.jp

モジラ、Firefox 3.1の“ポルノ・モード”詳細を公開──開発テスト版に実装 : ［特集］Webブラウザ - Computerworld.jp
モジラ、Firefox 3.1の“ポルノ・モード”詳細を公開──開発テスト版に実装 : ［特集］Webブラウザ

グーグル、OSネーティブなWebアプリの開発・実行環境「Native Client」をリリース : Googleウォッチ - Computerworld.jp
グーグル、OSネーティブなWebアプリの開発・実行環境「Native Client」をリリース : Googleウォッチ

//slashdot.jp

スラッシュドット・ジャパン | Gmailに「ボイス＆ビデオチャット機能」追加
Gmailに「ボイス＆ビデオチャット機能」追加

//markezine.jp

Gmailに音声＆ビデオチャット機能が登場：MarkeZine（マーケジン）
Gmailに音声＆ビデオチャット機能が登場

//japan.internet.com

グーグル、Gmail にて「音声・ビデオチャット機能」を提供 - japan.internet.com Webビジネス
グーグル、Gmail にて「音声・ビデオチャット機能」を提供

//internet.watch.impress.co.jp

IEのシェアが2カ月連続で70％を下回る、米Net Applications調査
IEのシェアが2カ月連続で70％を下回る、米Net Applications調査

グーグル、ブログ利用のプロモーションについて謝罪
グーグル、ブログ利用のプロモーションについて謝罪

//bb.watch.impress.co.jp

はてな、「うごメモはてな」の投稿作品数が10万件を突破
はてな、「うごメモはてな」の投稿作品数が10万件を突破

Eye-Fiが12月22日に出荷開始。国内ははてなとpaperboy&co.が対応
Eye-Fiが12月22日に出荷開始。国内ははてなとpaperboy&co.が対応

//www.watch.impress.co.jp

ネットブック用Atomを使った省電力マザー登場、システムTDPは半分以下、DVIも搭載
ネットブック用Atomを使った省電力マザー登場、システムTDPは半分以下、DVIも搭載

//itpro.nikkeibp.co.jp

オープンソースブラウザ，IE8とOperaを圧倒--JavaScript最新ベンチマーク：ITpro
オープンソースブラウザ，IE8とOperaを圧倒--JavaScript最新ベンチマーク

//sankei.jp.msn.com

【棋聖戦・梅田望夫氏観戦記】（１）桂の佐藤棋聖、銀の羽生挑戦者 (1/5ページ) - MSN産経ニュース
【棋聖戦・梅田望夫氏観戦記】（１）桂の佐藤棋聖、銀の羽生挑戦者

【断 横田由美子】不幸に甘える若者たち (1/2ページ) - MSN産経ニュース
【断 横田由美子】不幸に甘える若者たち

//it.nikkei.co.jp

グーグル、「Gmail」に位置情報機能を追加--メール執筆場所の通知を可能に[CNET Japan] インターネット-最新ニュース:IT-PLUS
グーグル、「Gmail」に位置情報機能を追加--メール執筆場所の通知を可能に

//japan.cnet.com

米ヤフー、検索プラットフォーム「Search BOSS」の有料化を発表:マーケティング - CNET Japan
米ヤフー、検索プラットフォーム「Search BOSS」の有料化を発表

//news.livedoor.com

livedoor ニュース - Microsoft、独自のスマートフォンを開発か
Microsoft、独自のスマートフォンを開発か

livedoor ニュース - まだ使ったことがないなら使うべきレベルに到達した体感速度爆速ブラウザ「Google Chrome」の真の実力
まだ使ったことがないなら使うべきレベルに到達した体感速度爆速ブラウザ「Google Chrome」の真の実力

//www.nhk.or.jp

NHKオンライン「ラボブログ」:NHKブログ | お知らせ | ニュース検索（beta版）、登場！
ニュース検索（beta版）、登場！

//www3.nhk.or.jp

NHKニュース
NHKニュース

NHKニュース　ＧＤＰ １０％以上マイナスか
ＧＤＰ １０％以上マイナスか
