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

//mainichi.jp

篤姫：最終回の視聴率は２８．７％　平均視聴率は過去１０年で最高 - 毎日ｊｐ(毎日新聞)
篤姫：最終回の視聴率は２８．７％　平均視聴率は過去１０年で最高

タイ：映画「闇の子供たち」、バンコク映画祭で上映中止 - 毎日ｊｐ(毎日新聞)
タイ：映画「闇の子供たち」、バンコク映画祭で上映中止

映画インタビュー：「闇の子供たち」阪本順治監督に聞く　「日本人にはね返ってくる映画にしたかった」 - 毎日ｊｐ(毎日新聞)
映画インタビュー：「闇の子供たち」阪本順治監督に聞く　「日本人にはね返ってくる映画にしたかった」

//headlines.yahoo.co.jp

ミニスカ美脚の宮崎あおい「ガッチガチに浣腸してます」との言い間違いを大爆笑!!（シネマトゥデイ） - Yahoo!ニュース
ミニスカ美脚の宮崎あおい「ガッチガチに浣腸してます」との言い間違いを大爆笑!!

//www.nikkansports.com
宮崎あおい「好きだ、」４年がかり公開 - nikkansports.com > 芸能ニュース
宮崎あおい「好きだ、」４年がかり公開

宮崎あおい「初恋」が初日 - シネマニュース : nikkansports.com
宮崎あおい「初恋」が初日
