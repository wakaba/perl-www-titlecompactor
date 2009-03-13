#!/usr/bin/perl 
# -*- mode: fundamental -*-
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
            if (s/^\$(a|c|sn?)\b\s*//) {
                # CAPTURABLE_FIELDS
                push @{$current_entry->{{
                    a => 'author', c => 'category', s => 'series', sn => 'series_number',
                }->{$1}} ||= []}, $_;
            } elsif (defined $current_entry->{input}) {
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
    $entry->{expected} = '' unless defined $entry->{expected};
    
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

        # CAPTURABLE_FIELDS
        for my $n (qw/category series series_number author/) {
            is $te->$n->join("\n"), join "\n", @{$entry->{$n} || []};
        }
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
$c スポーツ

asahi.com（朝日新聞社）：小室被告初公判、５億円詐欺認める　弁償はめど立たず - 社会
小室被告初公判、５億円詐欺認める　弁償はめど立たず
$c 社会

asahi.com:暗い所で本「目悪くなる」医学的根拠ないと米チーム
暗い所で本「目悪くなる」医学的根拠ないと米チーム

asahi.com:中学生と援交　取り立て受け家族が通報-マイタウン北海道
中学生と援交　取り立て受け家族が通報
$c マイタウン北海道

asahi.com:知的障害者も普通高へ-マイタウン愛媛
知的障害者も普通高へ
$c マイタウン愛媛

//mainichi.jp

篤姫：最終回の視聴率は２８．７％　平均視聴率は過去１０年で最高 - 毎日ｊｐ(毎日新聞)
篤姫：最終回の視聴率は２８．７％　平均視聴率は過去１０年で最高

タイ：映画「闇の子供たち」、バンコク映画祭で上映中止 - 毎日ｊｐ(毎日新聞)
タイ：映画「闇の子供たち」、バンコク映画祭で上映中止

映画インタビュー：「闇の子供たち」阪本順治監督に聞く　「日本人にはね返ってくる映画にしたかった」 - 毎日ｊｐ(毎日新聞)
「闇の子供たち」阪本順治監督に聞く　「日本人にはね返ってくる映画にしたかった」
$c 映画インタビュー

ワンダーフェスティバル：エスカレーター事故で中止の模型イベント 幕張メッセで７月再開へ(まんたんウェブ) - 毎日ｊｐ(毎日新聞)
ワンダーフェスティバル：エスカレーター事故で中止の模型イベント 幕張メッセで７月再開へ

//headlines.yahoo.co.jp

ミニスカ美脚の宮崎あおい「ガッチガチに浣腸してます」との言い間違いを大爆笑!!（シネマトゥデイ） - Yahoo!ニュース
ミニスカ美脚の宮崎あおい「ガッチガチに浣腸してます」との言い間違いを大爆笑!!
$c シネマトゥデイ

＜ハロープロジェクト＞安倍なつみ、中澤裕子、松浦亜弥ら大量25人が来年3月卒業へ（毎日新聞） - Yahoo!ニュース
＜ハロープロジェクト＞安倍なつみ、中澤裕子、松浦亜弥ら大量25人が来年3月卒業へ
$c 毎日新聞

//www.nikkansports.com

宮崎あおい「好きだ、」４年がかり公開 - nikkansports.com > 芸能ニュース
宮崎あおい「好きだ、」４年がかり公開
$c 芸能ニュース

宮崎あおい「初恋」が初日 - シネマニュース : nikkansports.com
宮崎あおい「初恋」が初日
$c シネマニュース

札幌「ハイテクタイツ」で４連戦乗り切る - サッカーニュース : nikkansports.com
札幌「ハイテクタイツ」で４連戦乗り切る
$c サッカーニュース

【ソフトＢ】多村が寝違えで別メニュー - プロ野球 オープン戦情報 : nikkansports.com
【ソフトＢ】多村が寝違えで別メニュー
$c プロ野球 オープン戦情報

//www.sanspo.com

元モー娘。、松浦亜弥ら来年３月でハロプロ卒業(サンケイスポーツ)
元モー娘。、松浦亜弥ら来年３月でハロプロ卒業

ハロプロ新星「まのえり」初写真集を増刷(サンケイスポーツ)
ハロプロ新星「まのえり」初写真集を増刷

掛布氏、読売テレビと契約解除 (1/2ページ) - 芸能 - SANSPO.COM
掛布氏、読売テレビと契約解除
$c 芸能

人気声優の平野綾が裸で水泳「誰もみてないし」 - 芸能 - SANSPO.COM
人気声優の平野綾が裸で水泳「誰もみてないし」
$c 芸能

仲村みう、１７歳で所属事務所の取締役に！ - 芸能 - SANSPO.COM
仲村みう、１７歳で所属事務所の取締役に！
$c 芸能

カネヒキリ、かしわ記念へ - 競馬 - SANSPO.COM
カネヒキリ、かしわ記念へ
$c 競馬

リケルメが代表離脱…マラドーナ監督と確執 - サッカー - SANSPO.COM
リケルメが代表離脱…マラドーナ監督と確執
$c サッカー

Ｇ・大阪、途中出場の佐々木がダメ押し点／ＡＣＬ （2） - サッカー - SANSPO.COM
Ｇ・大阪、途中出場の佐々木がダメ押し点／ＡＣＬ
$c サッカー

「おくりびと」が外国語映画賞を受賞／米アカデミー賞 - 芸能 - SANSPO.COM
「おくりびと」が外国語映画賞を受賞／米アカデミー賞
$c 芸能

【甘口辛口】２月２３日 - コラム - SANSPO.COM
２月２３日
$c コラム
$s 甘口辛口

ＦＣ東京・下田“サッカー偏差値”アップ (1/2ページ) - サッカー - SANSPO.COM
ＦＣ東京・下田“サッカー偏差値”アップ
$c サッカー

ＦＣ東京・下田“サッカー偏差値”アップ (2/2ページ) - サッカー - SANSPO.COM
ＦＣ東京・下田“サッカー偏差値”アップ
$c サッカー

//www.excite.co.jp

“押米”から９年ぶり！米米ＣＬＵＢが７カ月限定の再結成 | Excite エキサイト : ニュース
“押米”から９年ぶり！米米ＣＬＵＢが７カ月限定の再結成
$c ニュース

リクナビ求人「どこ行ってもうたんや…原君」の原君はホントに今どこで何をしているのか？！突撃取材！ | エキサイトニュース
リクナビ求人「どこ行ってもうたんや…原君」の原君はホントに今どこで何をしているのか？！突撃取材！

アマダナがポケットビデオカメラ「SAL」を発売 | ライフスタイル | エキサイトイズム
アマダナがポケットビデオカメラ「SAL」を発売
$c ライフスタイル

中古ソファの中に三毛猫が…… | エキサイトニュース
中古ソファの中に三毛猫が……

Twitterが強力なニュースメディアに（その1） | エキサイト ウェブアド タイムス
Twitterが強力なニュースメディアに

JRの駅のホームで聴こえる、鳥の鳴き声の正体とは？ | エキサイトニュース
JRの駅のホームで聴こえる、鳥の鳴き声の正体とは？

英国人の大半、読んでいない本も「読んだふり」＝調査 | エキサイトニュース
英国人の大半、読んでいない本も「読んだふり」＝調査

//www.itmedia.co.jp

ITIL Managerの視点から：初めてのサービスレベルアグリーメント【その2】 - ITmedia エンタープライズ
初めてのサービスレベルアグリーメント
$s ITIL Managerの視点から

ITIL Managerの視点から：初めてのサービスレベルアグリーメント【その3】 (1/2) 
初めてのサービスレベルアグリーメント
$s ITIL Managerの視点から

“世界初”トリプルエンジン搭載　TraceMonkey採用の「Lunascape 5.0α」 - ITmedia Biz.ID
“世界初”トリプルエンジン搭載　TraceMonkey採用の「Lunascape 5.0α」

IT Oasis：マニュアルを精読する人、まずスイッチをいれる人――新「気質分類」 (2/2) - ITmedia エンタープライズ
マニュアルを精読する人、まずスイッチをいれる人――新「気質分類」
$s IT Oasis

ITmedia Biz.ID : 入力の手間を省く、10のExcelショートカット
入力の手間を省く、10のExcelショートカット

「お前らの作品は所詮コピーだ」――富野由悠季さん、プロ論を語る (1/5) - ITmedia News
「お前らの作品は所詮コピーだ」――富野由悠季さん、プロ論を語る

Firefox Hacks：ブラウザの新境地？　Ubiquityが変える衝撃のブラウザ体験 (1/2) - ITmedia エンタープライズ
ブラウザの新境地？　Ubiquityが変える衝撃のブラウザ体験
$s Firefox Hacks

//blogs.itmedia.co.jp

けんじろう と コラボろう！ > 学校裏サイトで娘が実名で攻撃され、父としてメールを送ってみた。 : ITmedia オルタナティブ・ブログ
学校裏サイトで娘が実名で攻撃され、父としてメールを送ってみた。

一人シリコンバレー男 > 秋田県民としてノギャルに「違う」と叫びたい事 : ITmedia オルタナティブ・ブログ
秋田県民としてノギャルに「違う」と叫びたい事

ナレッジ！？情報共有・・・永遠の課題への挑戦 > 名刺管理のプロにきいたポケッター名刺の管理方法 : ITmedia オルタナティブ・ブログ
名刺管理のプロにきいたポケッター名刺の管理方法

//plusd.itmedia.co.jp

NHKオンライン、Wii向け「NHKニュース」を提供開始 - ITmedia +D Games
NHKオンライン、Wii向け「NHKニュース」を提供開始

「あなたに話しかける」　新iPod shuffle登場 - ITmedia +D LifeStyle
「あなたに話しかける」　新iPod shuffle登場

ナンバーは3倍、速度は8倍!?：“解像度不問”の高速読み取りを実現――「ScanSnap S1500」を試す (1/4) - ITmedia +D PC USER
ナンバーは3倍、速度は8倍!?：“解像度不問”の高速読み取りを実現――「ScanSnap S1500」を試す

App Town 天気：iPhoneアプリ「ウェザーニュース タッチ」に新機能――画面のカスタマイズが可能に - ITmedia +D モバイル
iPhoneアプリ「ウェザーニュース タッチ」に新機能――画面のカスタマイズが可能に
$s App Town 天気

//builder.japan.zdnet.com

グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ - builder by ZDNet Japan
グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ

「ReadMe!」の終焉が物語る、「養殖コミュニティ時代」の到来 - 山田井ユウキ - builder by ZDNet Japan
「ReadMe!」の終焉が物語る、「養殖コミュニティ時代」の到来
$a 山田井ユウキ

未来インターフェイス用のPhotoshopブラシ - yhassy - builder by ZDNet Japan
未来インターフェイス用のPhotoshopブラシ
$a yhassy

VPNサーバを構築してiPhoneからアクセス（4/4） - builder by ZDNet Japan
VPNサーバを構築してiPhoneからアクセス

LINQ練習 #3 「LINQ to SQL 条件式」 - 悠希 - builder by ZDNet Japan
LINQ練習 #3 「LINQ to SQL 条件式」
$a 悠希

周りはもう始めています　ネット上でのエリアターゲティング - サイバーエリアリサーチ　広報 - builder by ZDNet Japan
周りはもう始めています　ネット上でのエリアターゲティング
$a サイバーエリアリサーチ　広報

あなたのウェブサイトを高速化する方法 - page3 - builder by ZDNet Japan
あなたのウェブサイトを高速化する方法

//techtarget.itmedia.co.jp

Office Live Small Businessのビジネスアプリケーション機能を使う － TechTargetジャパン
Office Live Small Businessのビジネスアプリケーション機能を使う

データセンターの過熱問題――ネットワークスイッチに要注意 － TechTargetジャパン
データセンターの過熱問題――ネットワークスイッチに要注意

【Q＆A】Wi-FiとWiMAXの違いは？ － TechTargetジャパン
【Q＆A】Wi-FiとWiMAXの違いは？

HTTPエラーコード入門 PART1――HTTPステータスコードの意味 － TechTargetジャパン
HTTPエラーコード入門 PART1――HTTPステータスコードの意味

//japan.zdnet.com

グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ - インターネ - page2 - ZDNet Japan
グーグル、オープンソースのウェブブラウザ「Google Chrome」をまもなく公開へ
$c インターネ

ビジネスでの使用にあたって注意を必要とする危険な英単語12選 - IT業界を生き抜く秘密10箇 - ZDNet Japan
ビジネスでの使用にあたって注意を必要とする危険な英単語12選
$s IT業界を生き抜く秘密10箇

インクの未来 - The future of... - ZDNet Japan
インクの未来
$s The future of...

標準カーネル統合間近！TOMOYO Linuxの足跡：第1回--コミュニティの熱い力 - インタビュー - ZDNet Japan
標準カーネル統合間近！TOMOYO Linuxの足跡：第1回--コミュニティの熱い力
$c インタビュー

言語保護主義とシステム統合 - エンタープライズトレンドの読み方 - ZDNet Japan
言語保護主義とシステム統合
$s エンタープライズトレンドの読み方

「Internet Explorer 8」のリリースは3月20日--マイクロソフト台湾法人が言及 - ソフトウェ - ZDNet Japan
「Internet Explorer 8」のリリースは3月20日--マイクロソフト台湾法人が言及
$c ソフトウェ

パンデミック発生、企業が生き残るためには？--インフルエンザの感染爆発と事業継続のポイン - ZDNet Japan
パンデミック発生、企業が生き残るためには？--インフルエンザの感染爆発と事業継続のポイン

がんばった社員にボーナス以外のうれしい報酬--「あったらいいな」を実現する企業：日本HP - - ZDNet Japan
がんばった社員にボーナス以外のうれしい報酬--「あったらいいな」を実現する企業：日本HP

電話会議とPC画面共有できるサービスを無料で公開：ベイテックシステムズ - インターネット - ZDNet Japan
電話会議とPC画面共有できるサービスを無料で公開：ベイテックシステムズ
$c インターネット

マイクロソフト、「Windows 7」でIE以外にも多数の無効化オプションを提供へ - OS／プラット - ZDNet Japan
マイクロソフト、「Windows 7」でIE以外にも多数の無効化オプションを提供へ
$c OS／プラット

Windowsを健康に保つには -- 6つの性能向上ツールを紹介 - OS／プラットフォーム - ZDNet Japan
Windowsを健康に保つには -- 6つの性能向上ツールを紹介
$c OS／プラットフォーム

プロジェクト開始でも受注額が未定--工事進行基準適用後は混乱の原因に（後編） - まだ間に - ZDNet Japan
プロジェクト開始でも受注額が未定--工事進行基準適用後は混乱の原因に
$s まだ間に

2009年のPC需要は史上最悪の下げ幅に--ガートナー予測 - 企業情報 - ZDNet Japan
2009年のPC需要は史上最悪の下げ幅に--ガートナー予測
$c 企業情報

MS、Windows 7用に仮想化製品「App-V」をアップデート - オール・アバウト・マイクロソフト - ZDNet Japan
MS、Windows 7用に仮想化製品「App-V」をアップデート
$s オール・アバウト・マイクロソフト

［手のひらの中に広がる”redjuice”の世界］日本が誇るグラフィックアーチスト”redjuice” - ZDNet Japan
［手のひらの中に広がる”redjuice”の世界］日本が誇るグラフィックアーチスト”redjuice”

ネットワーク vs サーバ：休戦は終わり、戦争の時代へ - 企業情報 - ZDNet Japan
ネットワーク vs サーバ：休戦は終わり、戦争の時代へ
$c 企業情報

放射線画像の完全フィルムレス化でストレージ基盤刷新：静岡県立総合病院（前編） - 事例 - ZDNet Japan
放射線画像の完全フィルムレス化でストレージ基盤刷新：静岡県立総合病院
$c 事例

熱すぎるラックをお知らせ、｢警子ちゃんで温度監視｣ - ITマネジメント - ZDNet Japan
熱すぎるラックをお知らせ、｢警子ちゃんで温度監視｣
$c ITマネジメント

//codezine.jp

「Lunascape 5.0」アルファ版リリース、　世界最速JavaScriptエンジン「TraceMonkey」を搭載：CodeZine
「Lunascape 5.0」アルファ版リリース、　世界最速JavaScriptエンジン「TraceMonkey」を搭載

//journal.mycom.co.jp

Lunascape、世界最速JavaScriptエンジンとトリプルエンジン搭載のブラウザ | パソコン | マイコミジャーナル
Lunascape、世界最速JavaScriptエンジンとトリプルエンジン搭載のブラウザ
$c パソコン

Google、Gmailに音声/ビデオチャット機能を追加 | ネット | マイコミジャーナル
Google、Gmailに音声/ビデオチャット機能を追加
$c ネット

Railsマガジン1号登場、無料PDF版も | エンタープライズ | マイコミジャーナル
Railsマガジン1号登場、無料PDF版も
$c エンタープライズ

ネット騒然の著作権法改正案がHPで公開中 - 文部科学省 | ネット | マイコミジャーナル
ネット騒然の著作権法改正案がHPで公開中 - 文部科学省
$c ネット

【インタビュー】カシペンはこうして生まれた! - カシオ端末おなじみのキャラクター生誕の秘密を探る (1) カシオのものづくり思想「ハート・クラフト」とは? | 携帯 | マイコミジャーナル
カシペンはこうして生まれた! - カシオ端末おなじみのキャラクター生誕の秘密を探る (1) カシオのものづくり思想「ハート・クラフト」とは?
$c 携帯
$c インタビュー

【ハウツー】上手な海外旅行のためのエアライン最新事情(2)--値ごろ感があってサービスは向上! プレミアム・エコノミークラスお得度検証 (1) 広がった就航路線 | ライフ | マイコミジャーナル
上手な海外旅行のためのエアライン最新事情(2)--値ごろ感があってサービスは向上! プレミアム・エコノミークラスお得度検証 (1) 広がった就航路線
$c ライフ
$c ハウツー

【コラム】Windowsスマートチューニング (22) Vista編: 「電源プラン」をスマートに管理する | パソコン | マイコミジャーナル
Windowsスマートチューニング (22) Vista編: 「電源プラン」をスマートに管理する
$c パソコン
$c コラム

【コラム】少女漫画に学ぶ[ヲトメ心とレンアイ学] (90) 『BLACK BIRD』編～その1 | ホビー | マイコミジャーナル
少女漫画に学ぶ[ヲトメ心とレンアイ学] (90) 『BLACK BIRD』編～その1
$c ホビー
$c コラム

【レポート】富士通、次期スパコン向けHPC-ACEアーキテクチャを公表 (1) 次世代SPARCの仕様が公開 | エンタープライズ | マイコミジャーナル
富士通、次期スパコン向けHPC-ACEアーキテクチャを公表 (1) 次世代SPARCの仕様が公開
$c エンタープライズ
$c レポート

【レビュー】UQ WiMAXを千葉で試す (1) 繋がらないっ | パソコン | マイコミジャーナル
UQ WiMAXを千葉で試す (1) 繋がらないっ
$c パソコン
$c レビュー

【連載】セカイ系ウェブツール考 (63) 見た目が大事! Webサービスの「インタフェース」設計に使えるもの | ネット | マイコミジャーナル
セカイ系ウェブツール考 (63) 見た目が大事! Webサービスの「インタフェース」設計に使えるもの
$c ネット
$c 連載

【AIRコレ】Webで見つけた写真"とりあえずチェック"に便利な『PhotoTable』 | ネット | マイコミジャーナル
Webで見つけた写真"とりあえずチェック"に便利な『PhotoTable』
$c ネット
$c AIRコレ

//www.computerworld.jp

モジラ、Firefox 3.1の“ポルノ・モード”詳細を公開──開発テスト版に実装 : ［特集］Webブラウザ - Computerworld.jp
モジラ、Firefox 3.1の“ポルノ・モード”詳細を公開──開発テスト版に実装
$s ［特集］Webブラウザ

グーグル、OSネーティブなWebアプリの開発・実行環境「Native Client」をリリース : Googleウォッチ - Computerworld.jp
グーグル、OSネーティブなWebアプリの開発・実行環境「Native Client」をリリース
$s Googleウォッチ

サン、サーバ組み込み型の32GB・SSDモジュールを発表 : ストレージ革命 - Computerworld.jp
サン、サーバ組み込み型の32GB・SSDモジュールを発表
$s ストレージ革命

グーグル、個人のWeb閲覧履歴をAdSense広告の表示基準にする計画を明らかに : ソフトウェア＆サービス - Computerworld.jp
グーグル、個人のWeb閲覧履歴をAdSense広告の表示基準にする計画を明らかに
$c ソフトウェア＆サービス

米国政府のサイバー・セキュリティ対策責任者が辞職 : ［e・Gov］電子行政／電子政策 - Computerworld.jp
米国政府のサイバー・セキュリティ対策責任者が辞職
$c ［e・Gov］電子行政／電子政策

セキュリティ機能を購入して追加するモデルは時代遅れ──専門家が指摘 : セキュリティ - Computerworld.jp
セキュリティ機能を購入して追加するモデルは時代遅れ──専門家が指摘
$c セキュリティ

Acrobatの脆弱性突くプログラムを専門家が作成――アドビ推奨の自衛策を「回避」 : セキュリティ・マネジメント - Computerworld.jp
Acrobatの脆弱性突くプログラムを専門家が作成――アドビ推奨の自衛策を「回避」
$c セキュリティ・マネジメント

//slashdot.jp

スラッシュドット・ジャパン | Gmailに「ボイス＆ビデオチャット機能」追加
Gmailに「ボイス＆ビデオチャット機能」追加

環境専用のTLD、「.eco」が計画中 - スラッシュドット・ジャパン
環境専用のTLD、「.eco」が計画中

KNOPPIX 6.0.1 CD日本語版リリース - スラッシュドット・ジャパン
KNOPPIX 6.0.1 CD日本語版リリース

スラッシュドット・ジャパン | コーヒーメーカーの脆弱性が発覚
コーヒーメーカーの脆弱性が発覚

/.本家で日本の学生と選挙活動のひどさが話題に - スラッシュドット・ジャパン
/.本家で日本の学生と選挙活動のひどさが話題に

スラッシュドット ジャパン | プラスチック血液が開発
プラスチック血液が開発

個人情報未満の、名誉毀損未満 - DocSeri の日記 
個人情報未満の、名誉毀損未満

IT神話・Top10 - スラッシュドット・ジャパン
IT神話・Top10

//markezine.jp

Gmailに音声＆ビデオチャット機能が登場：MarkeZine（マーケジン）
Gmailに音声＆ビデオチャット機能が登場

//japan.internet.com

グーグル、Gmail にて「音声・ビデオチャット機能」を提供 - japan.internet.com Webビジネス
グーグル、Gmail にて「音声・ビデオチャット機能」を提供
$c Webビジネス

PDF にいろいろ書き込んで保存することができる「PDFVUE」 - japan.internet.com Webビジネス
PDF にいろいろ書き込んで保存することができる「PDFVUE」
$c Webビジネス

モバイル接触時間は、ラジオ・新聞・雑誌より長い――IMJ モバイル調べ - japan.internet.com Webマーケティング
モバイル接触時間は、ラジオ・新聞・雑誌より長い――IMJ モバイル調べ
$c Webマーケティング

オンライン広告.com 人気オンライン広告ランキング（2009年3月8日～14日） - japan.internet.com Webマーケティング
オンライン広告.com 人気オンライン広告ランキング（2009年3月8日～14日）
$c Webマーケティング

驚異的なV字回復を果たした無印良品の秘密【続編】 - japan.internet.com Webマーケティング
驚異的なV字回復を果たした無印良品の秘密【続編】
$c Webマーケティング

モバイルサイトは重要か？ Google モバイルの検索結果変更が与える影響 - japan.internet.com 携帯・ワイヤレス
モバイルサイトは重要か？ Google モバイルの検索結果変更が与える影響
$c 携帯・ワイヤレス

『Twitter』上の共有動画の優れた視聴手段となるか『Twitmatic』 - japan.internet.com Webマーケティング
『Twitter』上の共有動画の優れた視聴手段となるか『Twitmatic』
$c Webマーケティング

eBay の CEO、「Skype 買収への反省はこれで終わり」と明言 - japan.internet.com E-コマース
eBay の CEO、「Skype 買収への反省はこれで終わり」と明言
$c E-コマース

顧客には見せられない黒い仕様書…エンジニアの懺悔室 / エンジニア転職ノウハウ開発室 - japan.internet.com コラム
顧客には見せられない黒い仕様書…エンジニアの懺悔室
$c コラム
$s エンジニア転職ノウハウ開発室

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

//k-tai.watch.impress.co.jp

MS、SkyDriveと連携したWindows Mobile向け写真共有アプリ
MS、SkyDriveと連携したWindows Mobile向け写真共有アプリ

地図サービス「PetaMap」の携帯版が登場
地図サービス「PetaMap」の携帯版が登場

//pc.watch.impress.co.jp

レノボ、8.9型WSVGA液晶搭載のネットブック「IdeaPad S9e」
レノボ、8.9型WSVGA液晶搭載のネットブック「IdeaPad S9e」

CeBIT 2009レポート【Intelマザーボード編】P55マザーボードが計7製品。X58も新製品登場
CeBIT 2009レポート【Intelマザーボード編】P55マザーボードが計7製品。X58も新製品登場

//www.watch.impress.co.jp

ネットブック用Atomを使った省電力マザー登場、システムTDPは半分以下、DVIも搭載
ネットブック用Atomを使った省電力マザー登場、システムTDPは半分以下、DVIも搭載

//www.forest.impress.co.jp

窓の杜 - 【REVIEW】Firefoxの新規タブによく見るWebページをランキング表示「New Tab King」
Firefoxの新規タブによく見るWebページをランキング表示「New Tab King」
$c REVIEW

窓の杜 - 【週末ゲーム】第369回：リアル志向の3Dカーレースゲーム「VDrift」
リアル志向の3Dカーレースゲーム「VDrift」
$s 週末ゲーム
$sn 第369回

窓の杜 - 【NEWS】音楽や画像などのメディアファイルに対応した「ホワイトブラウザ」0.7.0.0 β
音楽や画像などのメディアファイルに対応した「ホワイトブラウザ」0.7.0.0 β
$c NEWS

窓の杜 - 【今日のお気に入り】和音と映像の電子楽器「サウノスヴァルカコンセプト」
和音と映像の電子楽器「サウノスヴァルカコンセプト」
$s 今日のお気に入り

窓の杜 - 【特集】デスクトップPCとの連携でネットブックをフル活用！ 前編
デスクトップPCとの連携でネットブックをフル活用！
$c 特集

//www.nikkei.co.jp

NIKKEI NET（日経ネット）：主要ニュース－各分野の重要ニュースを掲載
$c 主要ニュース

NIKKEI NET（日経ネット）：企業ニュース－企業の事業戦略、合併や提携から決算や人事まで速報
$c 企業ニュース

水辺のルネサンス（１）淀川シジミ、漁復活へかける | 日経ネット関西版
水辺のルネサンス（１）淀川シジミ、漁復活へかける

日本の観光競争力、25位に低下　外国人への開放性低く - NIKKEI NET
日本の観光競争力、25位に低下　外国人への開放性低く

「献金元は西松建設」、会社側が小沢氏秘書に伝達か : NIKKEI NET（日経ネット）：主要ニュース－各分野の重要ニュースを掲載
「献金元は西松建設」、会社側が小沢氏秘書に伝達か
$c 主要ニュース

NIKKEI NET（日経ネット）：国際ニュース－アメリカ、ＥＵ、アジアなど海外ニュースを速報
$c 国際ニュース

日立、「無給の休日」導入　毎月平日の１日、労組に提案 NIKKEI NET（日経ネット）：企業ニュース
日立、「無給の休日」導入　毎月平日の１日、労組に提案
$c 企業ニュース

NIKKEI NET（日経ネット）：国際ニュース－アメリカ、ＥＵ、アジアなど海外ニュースを速報
$c 国際ニュース

ベーカー元米財務長官「日本の失敗を繰り返すな」　英紙に寄稿:NIKKEI NET（日経ネット）：国際ニュース－アメリカ、ＥＵ、アジアなど海外ニュースを速報
ベーカー元米財務長官「日本の失敗を繰り返すな」　英紙に寄稿
$c 国際ニュース

NIKKEI NET（日経ネット）：経済ニュース －マクロ経済の動向から金融政策、業界の動きまでカバー
$c 経済ニュース

カード決済、「リボ払い」が増加　大手５社　08年末残高15％増　NIKKEI NET（日経ネット）：経済ニュース －マクロ経済の動向から金融政策、業界の動きまでカバー
カード決済、「リボ払い」が増加　大手５社　08年末残高15％増
$c 経済ニュース

米半導体大手スパンションが破綻　日本法人は2月に更生法申請　NIKKEI NET（日経ネット）
米半導体大手スパンションが破綻　日本法人は2月に更生法申請

NIKKEI NET（日経ネット）：社説・春秋－日本経済新聞の社説、1面コラムの春秋
$s 社説・春秋

社説２　「小沢政権」に不安を感じる(3/1) - NIKKEI NET（日経ネット）：社説・春秋−日本経済新聞の社説、1面コラムの春秋
「小沢政権」に不安を感じる(3/1)
$s 社説・春秋
$s 社説２

NET EYE プロの視点
$s NET EYE プロの視点

「痛車」ブームのマーケティング的考察 - NET EYE プロの視点
「痛車」ブームのマーケティング的考察
$s NET EYE プロの視点

米国が目指す『賢い電力網』というイノベーション（2009/3/3）　NET EYE プロの視点
米国が目指す『賢い電力網』というイノベーション（2009/3/3）
$s NET EYE プロの視点

//it.nikkei.co.jp

グーグル、「Gmail」に位置情報機能を追加--メール執筆場所の通知を可能に[CNET Japan] インターネット-最新ニュース:IT-PLUS
グーグル、「Gmail」に位置情報機能を追加--メール執筆場所の通知を可能に
$c [CNET Japan] インターネット-最新ニュース

//arena.nikkeibp.co.jp

“クリック・ホイール機能のみ”という新発想──｢クリッカープロ｣：デジタルARENA
“クリック・ホイール機能のみ”という新発想──｢クリッカープロ｣

片手で簡単。ケータイ感覚で文字入力──｢Keiboard+IE｣：デジタルARENA
片手で簡単。ケータイ感覚で文字入力──｢Keiboard+IE｣

マンガで学ぶ♪アリサの最新デジタル用語講座／ユビキタス：デジタルARENA
マンガで学ぶ♪アリサの最新デジタル用語講座／ユビキタス

Windows Vistaを快適に使う必殺技28：最新情報がザックザック　週刊Vistaです！
Windows Vistaを快適に使う必殺技28：最新情報がザックザック　週刊Vistaです！

え!?　Twitterじゃないの??　GoogleがミニブログのJaikuを買収した理由：デジタルARENA
え!?　Twitterじゃないの??　GoogleがミニブログのJaikuを買収した理由

FM・AMラジオもパソコンで再生──｢USB AM/FM Radio｣：デジタルARENA
FM・AMラジオもパソコンで再生──｢USB AM/FM Radio｣

//itpro.nikkeibp.co.jp

オープンソースブラウザ，IE8とOperaを圧倒--JavaScript最新ベンチマーク：ITpro
オープンソースブラウザ，IE8とOperaを圧倒--JavaScript最新ベンチマーク

//trendy.nikkeibp.co.jp

“クリック・ホイール機能のみ”という新発想──｢クリッカープロ｣ - デジタル - 日経トレンディネット
“クリック・ホイール機能のみ”という新発想──｢クリッカープロ｣

片手で簡単。ケータイ感覚で文字入力──｢Keiboard+IE｣ - デジタル - 日経トレンディネット
片手で簡単。ケータイ感覚で文字入力──｢Keiboard+IE｣

マンガで学ぶ♪アリサの最新デジタル用語講座／ユビキタス - デジタル - 日経トレンディネット
マンガで学ぶ♪アリサの最新デジタル用語講座／ユビキタス

Windows Vistaを快適に使う必殺技28 - デジタル - 日経トレンディネット
Windows Vistaを快適に使う必殺技28

え!?　Twitterじゃないの??　GoogleがミニブログのJaikuを買収した理由 - デジタル - 日経トレンディネット
え!?　Twitterじゃないの??　GoogleがミニブログのJaikuを買収した理由

FM・AMラジオもパソコンで再生──｢USB AM/FM Radio｣ - デジタル - 日経トレンディネット
FM・AMラジオもパソコンで再生──｢USB AM/FM Radio｣

//sankei.jp.msn.com

【棋聖戦・梅田望夫氏観戦記】（１）桂の佐藤棋聖、銀の羽生挑戦者 (1/5ページ) - MSN産経ニュース
【棋聖戦・梅田望夫氏観戦記】（１）桂の佐藤棋聖、銀の羽生挑戦者

【断 横田由美子】不幸に甘える若者たち (1/2ページ) - MSN産経ニュース
【断 横田由美子】不幸に甘える若者たち

//japan.cnet.com

米ヤフー、検索プラットフォーム「Search BOSS」の有料化を発表:マーケティング - CNET Japan
米ヤフー、検索プラットフォーム「Search BOSS」の有料化を発表
$c マーケティング

//news.livedoor.com

livedoor ニュース - Microsoft、独自のスマートフォンを開発か
Microsoft、独自のスマートフォンを開発か

livedoor ニュース - まだ使ったことがないなら使うべきレベルに到達した体感速度爆速ブラウザ「Google Chrome」の真の実力
まだ使ったことがないなら使うべきレベルに到達した体感速度爆速ブラウザ「Google Chrome」の真の実力

真っ赤なウソだった星野ＷＢＣ代表監督続投要請  livedoor スポーツ
真っ赤なウソだった星野ＷＢＣ代表監督続投要請

【杉山茂樹コラム】応援と観戦の乖離 - livedoor スポーツ
応援と観戦の乖離
$s 杉山茂樹コラム

漫画『リアル』作者・井上雄彦インタビュー “本当のリアル” - livedoor スポーツ
漫画『リアル』作者・井上雄彦インタビュー “本当のリアル”

【トレビアン動画】激アツに可愛いボウリング娘！ 見てるだけで何故か興奮!? - livedoor スポーツ
激アツに可愛いボウリング娘！ 見てるだけで何故か興奮!?
$s トレビアン動画

livedoor ニュース - 【トレビアン動画】激アツに可愛いボウリング娘！　見てるだけで何故か興奮!?
激アツに可愛いボウリング娘！　見てるだけで何故か興奮!?
$s トレビアン動画

【Sports Watch】甲子園でのラブシーン、その悲しい結末は？ - livedoor スポーツ
甲子園でのラブシーン、その悲しい結末は？
$s Sports Watch

livedoor ニュース - 【トレビアン】IE3で今のサイトにアクセスするとどうなるの？
IE3で今のサイトにアクセスするとどうなるの？
$s トレビアン

//blogs.livedoor.jp

説得力を持たせる提案、７つの流れとは？ - livedoor ディレクター Blog(ブログ)
説得力を持たせる提案、７つの流れとは？

//www.nhk.or.jp

NHKオンライン「ラボブログ」:NHKブログ | お知らせ | ニュース検索（beta版）、登場！
ニュース検索（beta版）、登場！
$c お知らせ

//www3.nhk.or.jp

NHKニュース

NHKニュース　ＧＤＰ １０％以上マイナスか
ＧＤＰ １０％以上マイナスか

//www.zakzak.co.jp

ZAKZAK

社会：ZAKZAK
$c 社会

ZAKZAK - 福留悩ます“Ｆ問題”英語で発音するとアノ禁止用語に
福留悩ます“Ｆ問題”英語で発音するとアノ禁止用語に

ユーザーショック…２ちゃんねる、再来週にもストップ - ZAKZAK
ユーザーショック…２ちゃんねる、再来週にもストップ

「パワー・フォー・リビング」ナゾの団体、１０億円ＣＭ攻勢…全国紙の大半“制覇” 聖書読め、中絶反対…キリスト教右派と関係深く - ZAKZAK
「パワー・フォー・リビング」ナゾの団体、１０億円ＣＭ攻勢…全国紙の大半“制覇” 聖書読め、中絶反対…キリスト教右派と関係深く

芸能：ZAKZAK
$c 芸能

芸能：ZAKZAK - 新ＥＸＩＬＥネット“大炎上”…初心忘れて結局「金」 
新ＥＸＩＬＥネット“大炎上”…初心忘れて結局「金」
$c 芸能

１００億円以上あったのに…小室、残高６２５９円 - 芸能：ZAKZAK
１００億円以上あったのに…小室、残高６２５９円
$c 芸能

萌え系アニメ～ドロドロ韓ドラまで…水樹奈々に直撃！ - 芸能：ZAKZAK
萌え系アニメ～ドロドロ韓ドラまで…水樹奈々に直撃！
$c 芸能

ＺＡＫだけが知っている児童ポルノ芸能プロの裏実態 芸能：ZAKZAK
ＺＡＫだけが知っている児童ポルノ芸能プロの裏実態
$c 芸能

芸能：ZAKZAK　ホリエモン拘置所生活を暴露「想像力でオナニーした」 
ホリエモン拘置所生活を暴露「想像力でオナニーした」
$c 芸能

ZAKZAK：クビ小向美奈子、グラビア界の“売春＆整形”暴露
クビ小向美奈子、グラビア界の“売春＆整形”暴露

「おくりびと」滝田監督、原点はピンク映画…妻は女優 芸能：ZAKZAK
「おくりびと」滝田監督、原点はピンク映画…妻は女優
$c 芸能

【芸能ニュース舞台裏】加藤監督「自分だけなら…」 
加藤監督「自分だけなら…」
$s 芸能ニュース舞台裏

//www.yomiuri.co.jp

「西松」献金、元秘書の要求発端…小沢代表参考人聴取へ : 社会 : YOMIURI ONLINE（読売新聞）
「西松」献金、元秘書の要求発端…小沢代表参考人聴取へ
$c 社会

西松献金事件、政府筋「自民まで波及する可能性ない」 : 西松献金事件 : 特集 : YOMIURI ONLINE（読売新聞）
西松献金事件、政府筋「自民まで波及する可能性ない」
$c 特集
$s 西松献金事件

小沢代表こもる、麻生首相「はしゃぐべきではない」 : 政治 : YOMIURI ONLINE（読売新聞）
小沢代表こもる、麻生首相「はしゃぐべきではない」
$c 政治

ｉＰＳ細胞から育てたマウス、１年後に６割発がん…山中教授 : 科学 : YOMIURI ONLINE（読売新聞）
ｉＰＳ細胞から育てたマウス、１年後に６割発がん…山中教授
$c 科学

トロッコ列車区間延長 : 島根 : 地域 : YOMIURI ONLINE（読売新聞）
トロッコ列車区間延長
$c 地域
$c 島根

宇宙飛行士を１時間５５０万円で“レンタル”…ＣＭ撮影などに : ニュース : 宇宙 : YOMIURI ONLINE（読売新聞）
宇宙飛行士を１時間５５０万円で“レンタル”…ＣＭ撮影などに
$c 宇宙
$c ニュース

「正社員採用せず」過去最悪の４５％…帝国データバンク調査 : 経済ニュース : マネー・経済 : YOMIURI ONLINE（読売新聞）
「正社員採用せず」過去最悪の４５％…帝国データバンク調査
$c マネー・経済
$c 経済ニュース

初音ミク「桜ノ雨」で卒業式…ネットで登場、希望殺到 : ニュース : エンタメ : YOMIURI ONLINE（読売新聞）
初音ミク「桜ノ雨」で卒業式…ネットで登場、希望殺到
$c エンタメ
$c ニュース

フェスティバル/トーキョー（Ｆ/Ｔ） : YOMIURI ONLINE（読売新聞）
フェスティバル/トーキョー（Ｆ/Ｔ）

日本の作家びっくり！申請なければ全文が米グーグルＤＢに : 社会 : YOMIURI ONLINE（読売新聞）
日本の作家びっくり！申請なければ全文が米グーグルＤＢに
$c 社会

米のＣＯ２観測衛星、打ち上げ失敗…南極付近に落下 : ニュース : 宇宙 : YOMIURI ONLINE（読売新聞）
米のＣＯ２観測衛星、打ち上げ失敗…南極付近に落下
$c 宇宙
$c ニュース

 「中国国営ＴＶは洗脳放送」ネットに視聴拒否声明 : 国際 : YOMIURI ONLINE（読売新聞）
「中国国営ＴＶは洗脳放送」ネットに視聴拒否声明
$c 国際

「ゆとり教育」見直す : 子どものニュースウイークリー : 子ども : 教育 : YOMIURI ONLINE（読売新聞）
「ゆとり教育」見直す
$c 教育
$c 子ども
$s 子どものニュースウイークリー

人気上昇中！カブトエビ、有機農法の新たな担い手に : 環境 : YOMIURI ONLINE（読売新聞）
人気上昇中！カブトエビ、有機農法の新たな担い手に
$c 環境

（上）読み上げソフト　対応まだまだ : 最前線 : 共生 : 医療と介護 : YOMIURI ONLINE（読売新聞）
読み上げソフト　対応まだまだ
$c 医療と介護
$c 共生
$c 最前線

（下）医療ケア充実　気兼ねなく : 最前線 : 共生 : 医療と介護 : YOMIURI ONLINE（読売新聞）
医療ケア充実　気兼ねなく
$c 医療と介護
$c 共生
$c 最前線

ＣＡＴＶはアナログ併存、地デジ移行後３〜５年 : ニュース : ネット＆デジタル : YOMIURI ONLINE（読売新聞）
ＣＡＴＶはアナログ併存、地デジ移行後３〜５年
$c ネット＆デジタル
$c ニュース

「ザ・ムーン」の監督インタビュー : 最新作紹介 : ヘザーの映画館 : エンタメ : YOMIURI ONLINE（読売新聞）
「ザ・ムーン」の監督インタビュー
$c エンタメ
$s ヘザーの映画館
$s 最新作紹介

良いところ　全然ない妻 : 家族・友人 : 人生案内 : YOMIURI ONLINE（読売新聞）
良いところ　全然ない妻
$c 人生案内
$c 家族・友人

//www.cnn.co.jp

CNN.co.jp：米国人の３人に１人、８６７０万人が健保未加入と
米国人の３人に１人、８６７０万人が健保未加入と

CNN.co.jp：米スキー場、風力発電で経費削減　生態系に悪影響の懸念も
米スキー場、風力発電で経費削減　生態系に悪影響の懸念も

CNN.co.jp：映画顔負け、囚人２人がヘリで脱獄　ギリシャ
映画顔負け、囚人２人がヘリで脱獄　ギリシャ

//b.hatena.ne.jp

美女が時間を知らせてくれる 「bijin-tokei（美人時計）」 - はてなブックマークニュース
美女が時間を知らせてくれる 「bijin-tokei（美人時計）」

週末に試したい、今週の人気レシピまとめ（2/26-3/6） - はてなブックマークニュース
週末に試したい、今週の人気レシピまとめ（2/26-3/6）

//wiredvision.jp

優れたフリーウェアでコンピューターを護ろう | WIRED VISION
優れたフリーウェアでコンピューターを護ろう

世界最大級の「再生可能エネルギープロジェクト」5選：中国やインドが中心 | WIRED VISION
世界最大級の「再生可能エネルギープロジェクト」5選：中国やインドが中心

ビル・ゲイツ家では『iPhone』禁止：メリンダ夫人インタビューで判明 | WIRED VISION
ビル・ゲイツ家では『iPhone』禁止：メリンダ夫人インタビューで判明

//www.4gamer.net

4Gamer.net ― Access Accepted第209回：「QUAKE LIVE」が導く先にあるもの
「QUAKE LIVE」が導く先にあるもの
$s Access Accepted
$sn 第209回

4Gamer.net ― 空冷＆常用を想定しつつ，Core i7のオーバークロック耐性を検証する（Core i7）
空冷＆常用を想定しつつ，Core i7のオーバークロック耐性を検証する（Core i7）

【4Gamer.net】 － 誰もがRPGを愛していた － 週刊連載
誰もがRPGを愛していた
$c 週刊連載

//www.atmarkit.co.jp

ユーザー参加のCM映像、YouTubeの成功事例 − ＠IT
ユーザー参加のCM映像、YouTubeの成功事例


連載：アニメーションで見るパケット君が住む町（1） − ＠IT
アニメーションで見るパケット君が住む町
$c 連載
$sn 1

プログラミングの真骨頂！ Javaで“反復処理”を覚える (1/3) - ＠IT
プログラミングの真骨頂！ Javaで“反復処理”を覚える

CIOは、ITをものにすべく努めよ− ＠IT情報マネジメント
CIOは、ITをものにすべく努めよ

Solaris ZFSの基本的な仕組みを知る（1/3）
Solaris ZFSの基本的な仕組みを知る

＠IT：Linux標準の仮想化技術「KVM」の仕組み（1/2）
Linux標準の仮想化技術「KVM」の仕組み

クリップボードの内容をリアルタイムに取得するには？［C#、VB］ － ＠IT
クリップボードの内容をリアルタイムに取得するには？［C#、VB］

がんばれ！アドミンくん 第163話 － ＠IT
がんばれ！アドミンくん 第163話

業種はメーカー、職種はコンサルがトップ―IT業界年収ランク － ＠IT
業種はメーカー、職種はコンサルがトップ―IT業界年収ランク

文字化けに関するトラブルに強くなる【実践編】（1/4） － ＠IT
文字化けに関するトラブルに強くなる【実践編】

D89クリップ（6）Adobe MAXレポート：Webにおけるグラフィック表現手段としてのFlash（1/1） - ＠IT
D89クリップ（6）Adobe MAXレポート：Webにおけるグラフィック表現手段としてのFlash

連載インデックス「jQueryで学ぶ簡単で効果的なAjaxの使い方」 - ＠IT
連載インデックス「jQueryで学ぶ簡単で効果的なAjaxの使い方」

［これはひどい］IEの引用符の解釈 － ＠IT
［これはひどい］IEの引用符の解釈

教科書に載らないWebアプリケーションセキュリティ 第1回 ［これはひどい］IEの引用符の解釈 − ＠IT
教科書に載らないWebアプリケーションセキュリティ 第1回 ［これはひどい］IEの引用符の解釈

＠IT Special PR： ミッションクリティカルなJavaシステムが抱える3つの課題
ミッションクリティカルなJavaシステムが抱える3つの課題

//jibun.atmarkit.co.jp

充実した人生のために今日からできること − ＠IT自分戦略研究所
充実した人生のために今日からできること

//www.iza.ne.jp

「小室哲哉被告　詐欺事件　第２回公判一覧」:イザ！
小室哲哉被告　詐欺事件　第２回公判一覧

「「済州島買ってしまえ」と小沢氏発言」:イザ！
「済州島買ってしまえ」と小沢氏発言

やるじゃん、iPhone　大澤亜季子の元気予報！：得ダネ情報：イザ！
やるじゃん、iPhone　大澤亜季子の元気予報！
$c 得ダネ情報

「【人】１３人のプロ選手を送り出す流通経大サッカー部監督　中野雄二さん（４６）」:イザ！
１３人のプロ選手を送り出す流通経大サッカー部監督　中野雄二さん（４６）
$s 人

「【主張】子供の権利　わがまま許す条例は疑問」:イザ！
子供の権利　わがまま許す条例は疑問
$s 主張

「【サブカルちゃんねる】岐路に立つアニメ産業　鍵はネット」:イザ！
岐路に立つアニメ産業　鍵はネット
$s サブカルちゃんねる

「【アートクルーズ】「キリル文字をポスターに」展　ブルガリア生まれの「知的資産」」:イザ！
「キリル文字をポスターに」展　ブルガリア生まれの「知的資産」
$s アートクルーズ

「【増える介護離職】（上）不況で再就職なく…共倒れ寸前」:イザ！
不況で再就職なく…共倒れ寸前
$s 増える介護離職
$sn 上

「【コラム・断】がんの治療は最後までしない」:イザ！
がんの治療は最後までしない
$s コラム・断

//www.sponichi.co.jp

有終Ｖキストゥ！交配相手はチチカステナンゴ最有力（競馬） ― スポニチ Sponichi Annex ニュース
有終Ｖキストゥ！交配相手はチチカステナンゴ最有力
$c 競馬

さわやか封印！櫻井翔が“くせ者”司会者（芸能） ― スポニチ Sponichi Annex ニュース
さわやか封印！櫻井翔が“くせ者”司会者
$c 芸能


強さ本物！自演乙、ＴＫＯ負けもキラッ☆（格闘技） ― スポニチ Sponichi Annex ニュース
強さ本物！自演乙、ＴＫＯ負けもキラッ☆
$c 格闘技

//news.goo.ne.jp

労働組合は社員の敵：城繁幸（joe’s Labo代表取締役）（4）(Voice) - goo ニュース
労働組合は社員の敵：城繁幸（joe’s Labo代表取締役）

オバマ氏の左シフトは、戦術的なフェイントなどではない――フィナンシャル・タイムズ(フィナンシャル・タイムズ) - goo ニュース
オバマ氏の左シフトは、戦術的なフェイントなどではない

日本にもまだ政府は必要だ――フィナンシャル･タイムズ社説(フィナンシャル・タイムズ) - goo ニュース
日本にもまだ政府は必要だ
$c 社説

＜特集ワイド＞オウム事件被害者・河野義行さんの心の軌跡(毎日新聞) - goo ニュース
オウム事件被害者・河野義行さんの心の軌跡
$s 特集ワイド

卒業アルバム、男女で購入に温度差　関西の大学(神戸新聞) - goo ニュース
卒業アルバム、男女で購入に温度差　関西の大学

オバマ政権はリベラルか・保守も取り込んだ「おやじキラー」（上）(gooニュース) - goo ニュース
オバマ政権はリベラルか・保守も取り込んだ「おやじキラー」

末期がんの英老夫婦、スイスのクリニックで幇助自殺(時事通信) - goo ニュース
末期がんの英老夫婦、スイスのクリニックで幇助自殺


自宅の部屋全てをネット上で簡単に監視できるシステム『Vue』(WIRED VISION) - goo ニュース
自宅の部屋全てをネット上で簡単に監視できるシステム『Vue』

「ゆうこりん」芸能プロの脱税商法(ファクタ) - goo ニュース
「ゆうこりん」芸能プロの脱税商法

原風紀委員長「ヒゲ面、金髪は厳禁」…ではアノ男も？(夕刊フジ) - goo ニュース
原風紀委員長「ヒゲ面、金髪は厳禁」…ではアノ男も？

1ドル70円台の日本経済：三橋貴明(作家)（１）(Voice) - goo ニュース
1ドル70円台の日本経済：三橋貴明(作家)

憲法に違反してまで改革潰し：高橋洋一(東洋大学教授)(Voice) - goo ニュース
憲法に違反してまで改革潰し：高橋洋一(東洋大学教授)

派遣村騒動で「心の病」を持つ会社員の復職が続出(ダイヤモンド・オンライン) - goo ニュース
派遣村騒動で「心の病」を持つ会社員の復職が続出

行列のできるバームクーヘンのヒミツ――それゆけ！カナモリさん(GLOBIS.JP) - goo ニュース
行列のできるバームクーヘンのヒミツ――それゆけ！カナモリさん

【仕事人】靴磨き職人・長谷川裕也（２４）　足元から革命…日本に元気を(産経新聞) - goo ニュース
靴磨き職人・長谷川裕也（２４）　足元から革命…日本に元気を
$s 仕事人

2009年、私たちの誓いは　野村彰男コラム「回る地球儀」　＜特集・危機の時代を生きる＞(gooニュース) - goo ニュース
2009年、私たちの誓いは　野村彰男コラム「回る地球儀」
$s 特集・危機の時代を生きる

【こぼれ話】一夜にして１３兆円の借金＝銀行のオンラインミス−英国(時事通信) - goo ニュース
一夜にして１３兆円の借金＝銀行のオンラインミス−英国
$s こぼれ話

小田嶋隆の「ア・ピース・オブ・警句」 ～世間に転がる意味不明　「ハケン切り」の品格　「派遣切り」（用途：労働問題を真面目に考えたくない際に）(日経ビジネスオンライン) - goo ニュース
小田嶋隆の「ア・ピース・オブ・警句」 ～世間に転がる意味不明　「ハケン切り」の品格　「派遣切り」（用途：労働問題を真面目に考えたくない際に）

goo注目ワード ピックアップ・・・非モテSNS(goo注目ワード) - goo ニュース
goo注目ワード ピックアップ・・・非モテSNS

//gihyo.jp

FreeBSD Daily Topics：2009年3月16日　≪Tips≫linux_base-f8をインストールして使う方法（日本語ロケール設定，日本標準時設定あり）≪注目≫AsiaBSDCon2009開催報告・勉強会告知｜gihyo.jp … 技術評論社
≪Tips≫linux_base-f8をインストールして使う方法（日本語ロケール設定，日本標準時設定あり）≪注目≫AsiaBSDCon2009開催報告・勉強会告知
$s FreeBSD Daily Topics
$sn 2009年3月16日

タイム・マネジメントの心得　～あなたを多忙から開放する10の方法～：第11回　日誌をつける | エンジニアマインド … 技術評論社
日誌をつける
$s タイム・マネジメントの心得　～あなたを多忙から開放する10の方法～
$sn 第11回

Ruby Freaks Lounge：第3回　Ruby1.9の新機能ひとめぐり（中編）：洗練された文法と意味論｜gihyo.jp … 技術評論社
Ruby1.9の新機能ひとめぐり（中編）：洗練された文法と意味論
$s Ruby Freaks Lounge
$sn 第3回

【PHPで作る】初めての携帯サイト構築：第6回　携帯サイトのテストをする｜gihyo.jp … 技術評論社
携帯サイトのテストをする
$s 【PHPで作る】初めての携帯サイト構築
$sn 第6回

週刊Webテク通信：2009年2月第4週号　1位は，CSSでの縦方向のセンタリング／気になるネタは，アップル，Safari 4を発表｜gihyo.jp … 技術評論社
1位は，CSSでの縦方向のセンタリング／気になるネタは，アップル，Safari 4を発表
$s 週刊Webテク通信
$sn 2009年2月第4週号

ついにベールを脱いだJavaFX：第14回　補遺：JavaFX Scriptマイグレーションガイド｜gihyo.jp … 技術評論社
補遺：JavaFX Scriptマイグレーションガイド
$s ついにベールを脱いだJavaFX
$sn 第14回

連載：Ruby Freaks Lounge｜gihyo.jp … 技術評論社
Ruby Freaks Lounge
$c 連載

WEB+DB PRESS Vol.49：サポートページ｜gihyo.jp … 技術評論社
WEB+DB PRESS Vol.49：サポートページ

濃縮還元オレンジニュース：Yahoo! JAPANがyimg.jpドメインを使うのは，悪意あるFlashから自社ドメインのCookieを守るため｜gihyo.jp … 技術評論社
Yahoo! JAPANがyimg.jpドメインを使うのは，悪意あるFlashから自社ドメインのCookieを守るため
$s 濃縮還元オレンジニュース

［はまちちゃんのセキュリティ講座］ここがキミの脆弱なところ…！：第4回　CSRF対策完結編～トークンでトークしよう！｜gihyo.jp … 技術評論社
CSRF対策完結編～トークンでトークしよう！
$s ［はまちちゃんのセキュリティ講座］ここがキミの脆弱なところ…！
$sn 第4回

//ascii.jp

日本発の最注目サイト「pixiv」のヒミツ（後編）
日本発の最注目サイト「pixiv」のヒミツ

1秒起動のお手軽ビデオカメラ　amadana「SAL」
1秒起動のお手軽ビデオカメラ　amadana「SAL」

【価格調査】人気のUSBサブディスプレイ、実売価格を徹底調査
【価格調査】人気のUSBサブディスプレイ、実売価格を徹底調査
