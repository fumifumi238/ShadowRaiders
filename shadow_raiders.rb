require "bundler/setup"
require 'discordrb'
require 'json'
require 'dotenv'

Dotenv.load

TOKEN = ENV["TOKEN"]
CLIENT_ID = ENV["CLIENT_ID"]

bot = Discordrb::Commands::CommandBot.new token: TOKEN , client_id: CLIENT_ID,prefix: ''
s = ["ウラヌス","ウルリッヒ","ワルプルギス","ワイト","復讐の女神","アルスター","ヴァンパイア","狼男","ベノム"]
r = ["エミ","エリカ","フェリックス","ガラハド","フレディ","エマ","ゴドウィン","フェリシア","ゴードン"]
c = ["アリス","アガサ","デーヴィッド","ベンジャミン","バイロン","デボラ","アンジェラ","キャロル","クレイグ","クレア","ブルース","ダニエル"]

your_board = []
num = 0
i = 0

File.open("chara.json") do |file|
  hash = JSON.load(file)
 bot.command :what do |event,chara|
  if hash[chara] == nil
  event.respond"#{chara}というキャラクターは存在しません"
  else
  event.respond"#{hash[chara]}"
  end
 end
end

bot.command :chara do |event|
  event.respond"シャドウ：\n\nウラヌス\nウルリッヒ\nワルプルギス\nワイト\n復讐の女神\nアルスター\nヴァンパイア\n狼男\nベノム
  \n\nレイダー：\n\nエミ\nエリカ\nフェリックス\nガラハド\nフレディ\nエマ\nゴドウィン\nフェリシア\nゴードン
  \n\nシチズン：\n\nアリス\nアガサ\nデーヴィッド\nベンジャミン\nバイロン\nデボラ\nアンジェラ\nキャロル\nクレイヴ\nクレア\nブルース\nダニエル"
end

bot.command :board do |event|
  event.respond"2~3:探偵事務所\n推理カードを山から1枚引くことができる。\n\n4~5:ブラックミスト地区\n好きな山からカードを1枚引くことができる。
\n\n6:大聖堂\n白のカードを山から1枚引くことができる。\n\n7:地下通路\n黒のカードを山から1枚引くことができる。\n\n8:市庁舎\n任意のプレイヤーを1人選び、2ダメージ与えるか、
または1ダメージ回復することができる。\n\n9:オリバーの隠れ家\n他のキャラクターが持つ任意の装備カード1つを獲得することができる。\n\n
10:女王陛下の飛行船\n次の手番の移動時、ダイスを振らずに隣接する任意のエリアに移動できる。"
end

bot.command :ex do |event|
  event.respond "b：黒のカードを引く\nw：白のカードを引く\ng：推理カードを引く\nchara:キャラクター一覧を表示する\nboard:ボードの詳細を表示する
  \nd：6面ダイスと4面ダイスを振る\nstart x y z：シャドウx枚、レイダーy枚、シチズンz枚で始める\nselect：キャラクターカードを割り当てる\nwhat キャラクター名：キャラクターの詳細を表示する"
end


bot.command :d do |event|
  event.respond "6面ダイス:　#{rand(1..6)}\n4面ダイス:　#{rand(1..4)}"
end

def set_cards(color)
  File.open("#{color}.json") do |file|
  cards = JSON.load(file)
  puts cards
  cards
  end
end

set_cards("green")

green = {"1"=>"君はシチズンかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"2"=>"君はシチズンかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"3"=>"君はシチズンかレイダーだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"4"=>"君はシチズンかレイダーだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"5"=>"君はレイダーかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"6"=>"君はレイダーかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"7"=>"君はレイダーだね。\nだったら1ダメージ受けたまえ。",
"8"=>"君はレイダーだね。\nだったら1ダメージ受けたまえ。",
"9"=>"君はレイダーだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
"10"=>"君はレイダーだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
"11"=>"君はシチズンだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
"12"=>"君はシチズンだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
"13"=>"君は自分のキャラクターカードを手番プレイヤーだけにこっそりと見せたまえ。",
"14"=>"君はHPが12以上だね。\nだったら2ダメージ受けたまえ。",
"15"=>"君はHPが11以下だね。\nだったら1ダメージ受けたまえ。",
"16"=>"君はシャドウだね。\nだったら2ダメージ受けたまえ",
"17"=>"君はシャドウだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
"18"=>"君はシャドウだね。\nだったら1ダメージ受けたまえ。",
"19"=>"君はシャドウだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
"20"=>"君はシャドウだね。\nだったら2ダメージ受けたまえ"}

bot.command :g do |event|
if green.length == 0
  green = {"1"=>"君はシチズンかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
  "2"=>"君はシチズンかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
  "3"=>"君はシチズンかレイダーだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
  "4"=>"君はシチズンかレイダーだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
  "5"=>"君はレイダーかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
  "6"=>"君はレイダーかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
  "7"=>"君はレイダーだね。\nだったら1ダメージ受けたまえ。",
  "8"=>"君はレイダーだね。\nだったら1ダメージ受けたまえ。",
  "9"=>"君はレイダーだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
  "10"=>"君はレイダーだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
  "11"=>"君はシチズンだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
  "12"=>"君はシチズンだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
  "13"=>"君は自分のキャラクターカードを手番プレイヤーだけにこっそりと見せたまえ。",
  "14"=>"君はHPが12以上だね。\nだったら2ダメージ受けたまえ。",
  "15"=>"君はHPが11以下だね。\nだったら1ダメージ受けたまえ。",
  "16"=>"君はシャドウだね。\nだったら2ダメージ受けたまえ",
  "17"=>"君はシャドウだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
  "18"=>"君はシャドウだね。\nだったら1受けたまえ。",
  "19"=>"君はシャドウだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
  "20"=>"君はシャドウだね。\nだったら2ダメージ受けたまえ"
  }

end
key = green.keys.sample
_message = "#{green[key]}\n推理カードは残り#{green.length-1}枚です。"
 green.delete(key)
event.send_message(_message)
end

black = {"1"=>"「死神のスコープ」

【装備】

あなたの攻撃レンジは+1される",
"2"=>"「死神のスコープ」

【装備】

あなたの攻撃レンジは+1される",

"3"=>"「オリバーの子分」
　
【使い捨て】
　
他のプレイヤーが所持している任意の装備カードを1つ獲得する",
"4"=>"「オリバーの子分」
　
【使い捨て】

他のプレイヤーが所持している任意の装備カードを1つ獲得する",

"5"=>"「オリバーの子分」
　
【使い捨て】
　
他のプレイヤーが所持している任意の装備カードを1つ獲得する",
"6"=>"「三つ目の黒犬」

【使い捨て】　

あなたと、あなた以外の任意のプレイヤー1人に2ダメージずつ与える",
"7"=>"「三つ目の黒犬」

【使い捨て】　

あなたと、あなた以外の任意のプレイヤー1人に2ダメージずつ与える",
"8"=>"「吸血コウモリ」

【使い捨て】　

あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
"9"=>"「吸血コウモリ」

【使い捨て】　

あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
"10"=>"「吸血コウモリ」

【使い捨て】
　
あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
"11"=>"「ガトリング」

【装備】　

あなたの攻撃は、攻撃可能レンジにいるすべてのプレイヤーに対して行われる。(ダイスは1度だけ振り、それを全員に適用する)",
"12"=>"「拳銃【L】」

【装備】　

あなたの攻撃が成功したとき、ダメージが1増加する。",
"13"=>"「拳銃【R】」

【装備】
　
あなたの攻撃が成功したとき、ダメージが1増加する。",
"14"=>"「サーベル」

【装備】　

あなたの攻撃が成功したとき、ダメージが1増加する。",
"15"=>"「クロスボウガン」

【装備】　

あなたの攻撃が成功したとき、ダメージが1増加する。",
"16"=>"「妖刀マサムネ」

【装備】

あなたは攻撃可能なレンジに他のプレイヤーがいる限り必ず攻撃を行わなければならない。この攻撃は4面ダイスのみを使用し、その出目と同数の攻撃ダメージを与える。",
"17"=>"「バナナの皮」

【使い捨て】　

あなたが所持している任意の装備1つを、他の任意のプレイヤーに渡す。装備を持っていない場合、あなたは1ダメージを受ける。",
"18"=>"「暴動」

【使い捨て】　

ダイスを振り、出目に対応したエリアカードにいる全てのプレイヤーに3ダメージを与える。(10の場合は何も起こらない)",
"19"=>" 「戦慄の闇儀式」

【使い捨て】　

あなたがシャドウの場合、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。",
"20"=>"「呪いの人形」

【使い捨て】　

他のプレイヤー1人を選び6面ダイスを振る。出目が1~4の場合は選ばれたプレイヤーが、5~6の場合はあなたが3ダメージを受ける。"
}

bot.command :b do |event|
if black.length == 0
  black = {"1"=>"「死神のスコープ」

  【装備】

  あなたの攻撃レンジは+1される",
  "2"=>"「死神のスコープ」

  【装備】

  あなたの攻撃レンジは+1される",

  "3"=>"「オリバーの子分」
  　
  【使い捨て】
  　
  他のプレイヤーが所持している任意の装備カードを1つ獲得する",
  "4"=>"「オリバーの子分」
  　
  【使い捨て】

  他のプレイヤーが所持している任意の装備カードを1つ獲得する",

  "5"=>"「オリバーの子分」
  　
  【使い捨て】
  　
  他のプレイヤーが所持している任意の装備カードを1つ獲得する",
  "6"=>"「三つ目の黒犬」

  【使い捨て】　

  あなたと、あなた以外の任意のプレイヤー1人に2ダメージずつ与える",
  "7"=>"「三つ目の黒犬」

  【使い捨て】　

  あなたと、あなた以外の任意のプレイヤー1人に2ダメージずつ与える",
  "8"=>"「吸血コウモリ」

  【使い捨て】　

  あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
  "9"=>"「吸血コウモリ」

  【使い捨て】　

  あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
  "10"=>"「吸血コウモリ」

  【使い捨て】
  　
  あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
  "11"=>"「ガトリング」

  【装備】　

  あなたの攻撃は、攻撃可能レンジにいるすべてのプレイヤーに対して行われる。(ダイスは1度だけ振り、それを全員に適用する)",
  "12"=>"「拳銃【L】」

  【装備】　

  あなたの攻撃が成功したとき、ダメージが1増加する。",
  "13"=>"「拳銃【R】」

  【装備】
  　
  あなたの攻撃が成功したとき、ダメージが1増加する。",
  "14"=>"「サーベル」

  【装備】　

  あなたの攻撃が成功したとき、ダメージが1増加する。",
  "15"=>"「クロスボウガン」

  【装備】　

  あなたの攻撃が成功したとき、ダメージが1増加する。",
  "16"=>"「妖刀マサムネ」

  【装備】

  あなたは攻撃可能なレンジに他のプレイヤーがいる限り必ず攻撃を行わなければならない。この攻撃は4面ダイスのみを使用し、その出目と同数の攻撃ダメージを与える。",
  "17"=>"「バナナの皮」

  【使い捨て】　

  あなたが所持している任意の装備1つを、他の任意のプレイヤーに渡す。装備を持っていない場合、あなたは1ダメージを受ける。",
  "18"=>"「暴動」

  【使い捨て】　

  ダイスを振り、出目に対応したエリアカードにいる全てのプレイヤーに3ダメージを与える。(10の場合は何も起こらない)",
  "19"=>" 「戦慄の闇儀式」

  【使い捨て】　

  あなたがシャドウの場合、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。",
  "20"=>"「呪いの人形」

  【使い捨て】　

  他のプレイヤー1人を選び6面ダイスを振る。出目が1~4の場合は選ばれたプレイヤーが、5~6の場合はあなたが3ダメージを受ける。"
  }
end

key = black.keys.sample
_message = "#{black[key]}\n \n
 黒のカードは残り#{black.length-1}枚です。"
 black.delete(key)
 event.send_message(_message)
end

white = {"1"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",
"2"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",

"3"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",
"4"=>"「銀のロザリオ」
　
【装備】

あなたの攻撃によって他のプレイヤーが脱落したとき、そのプレイヤーの所持していた装備カードを全て獲得する。",

"5"=>"「銀のロザリオ」
　
【装備】
　
あなたの攻撃によって他のプレイヤーが脱落したとき、そのプレイヤーの所持していた装備カードを全て獲得する。",
"6"=>"「幸運のブローチ」

【装備】　

あなたはエリアカード【市庁舎】の効果によるダメージを受けない。(回復は行える)",
"7"=>"「賢者のローブ」

【装備】　

あなたが行った攻撃のダメージが1減少する。あなたに対して行われた攻撃のダメージが1減少する。(この結果1ダメージが0ダメージになった場合、攻撃失敗になる)",
"8"=>"「神秘のコンパス」

【装備】　

あなたが移動するとき、ダイスを二度振り、どちらかの出目を選んで移動する。",
"9"=>"「虹色のパラソル」

【装備】　

あなたは攻撃を行う代わりに、推理カードを1枚引いてただちにレンジ内にいるプレイヤーに対して使用することができる。",
"10"=>"「いにしえの聖杯」

【装備】
　
あなたは黒のカード【三つ目の黒犬】【吸血コウモリ】【呪いの人形】によるダメージを受けない。",
"11"=>"「エクスカリバー」

【装備】　

あなたの攻撃が成功したとき、あなたがレイダーであれば正体を公開してもよい。公開した場合、ダメージが2増加する。",
"12"=>"「守護天使」

【使い捨て】　

次のあなたの手番の最初まで、あなたは攻撃によるダメージを受けない。",
"13"=>"「裁きの閃光」

【使い捨て】
　
あなた以外のプレイヤーは全員2ダメージを受ける。",
"14"=>"「人魚の涙」

【使い捨て】　

現在最もダメージの大きいプレイヤーのダメージを3回復する。(該当するプレイヤーが複数いる場合はその全員が回復)",
"15"=>"「恩恵」

【使い捨て】　

あなた以外のプレイヤー1人を選び、6面ダイスを振る。そのプレイヤーは出目と同数のダメージを回復する。",
"16"=>"「闇を祓う鏡」

【使い捨て】

あなたがウラヌス/アルスター/ヴァンパイア/復讐の女神/蟲毒使い/狼男/ワルプルギス/ワイトのとき、あなたは自分の正体を公開しなければならない。",
"17"=>"「応急手当」

【使い捨て】　

任意のプレイヤー1人のダメージを7にする。(あなた自身を選んでもよい)",
"18"=>"「光臨」

【使い捨て】　

あなたがレイダーの場合、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。",
"19"=>" 「封印の知恵」

【使い捨て】　

この手番の終了後、もう一度あなたの手番を行う。",
"20"=>"「幸せのクッキー」

【使い捨て】　

あなたがアリス/アンジェラ/アガサ/ウルリッヒ/ウラヌス/アルスター/のとき、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。"
}
bot.command :w do |event|
if white.length == 0
white = {"1"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",
"2"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",

"3"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",
"4"=>"「銀のロザリオ」
　
【装備】

あなたの攻撃によって他のプレイヤーが脱落したとき、そのプレイヤーの所持していた装備カードを全て獲得する。",

"5"=>"「銀のロザリオ」
　
【装備】
　
あなたの攻撃によって他のプレイヤーが脱落したとき、そのプレイヤーの所持していた装備カードを全て獲得する。",
"6"=>"「幸運のブローチ」

【装備】　

あなたはエリアカード【市庁舎】の効果によるダメージを受けない。(回復は行える)",
"7"=>"「賢者のローブ」

【装備】　

あなたが行った攻撃のダメージが1減少する。あなたに対して行われた攻撃のダメージが1減少する。(この結果1ダメージが0ダメージになった場合、攻撃失敗になる)",
"8"=>"「神秘のコンパス」

【装備】　

あなたが移動するとき、ダイスを二度振り、どちらかの出目を選んで移動する。",
"9"=>"「虹色のパラソル」

【装備】　

あなたは攻撃を行う代わりに、推理カードを1枚引いてただちにレンジ内にいるプレイヤーに対して使用することができる。",
"10"=>"「いにしえの聖杯」

【装備】
　
あなたは黒のカード【三つ目の黒犬】【吸血コウモリ】【呪いの人形】によるダメージを受けない。",
"11"=>"「エクスカリバー」

【装備】　

あなたの攻撃が成功したとき、あなたがレイダーであれば正体を公開してもよい。公開した場合、ダメージが2増加する。",
"12"=>"「守護天使」

【使い捨て】　

次のあなたの手番の最初まで、あなたは攻撃によるダメージを受けない。",
"13"=>"「裁きの閃光」

【使い捨て】
　
あなた以外のプレイヤーは全員2ダメージを受ける。",
"14"=>"「人魚の涙」

【使い捨て】　

現在最もダメージの大きいプレイヤーのダメージを3回復する。(該当するプレイヤーが複数いる場合はその全員が回復)",
"15"=>"「恩恵」

【使い捨て】　

あなた以外のプレイヤー1人を選び、6面ダイスを振る。そのプレイヤーは出目と同数のダメージを回復する。",
"16"=>"「闇を祓う鏡」

【使い捨て】

あなたがウラヌス/アルスター/ヴァンパイア/復讐の女神/ベノム/狼男/ワルプルギス/ワイトのとき、あなたは自分の正体を公開しなければならない。",
"17"=>"「応急手当」

【使い捨て】　

任意のプレイヤー1人のダメージを7にする。(あなた自身を選んでもよい)",
"18"=>"「光臨」

【使い捨て】　

あなたがレイダーの場合、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。",
"19"=>" 「封印の知恵」

【使い捨て】　

この手番の終了後、もう一度あなたの手番を行う。",
"20"=>"「幸せのクッキー」

【使い捨て】　

あなたがアリス/アンジェラ/アガサ/ウルリッヒ/ウラヌス/アルスター/のとき、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。"
}
end

key = white.keys.sample
_message = "#{white[key]}\n \n白のカードは残り#{white.length-1}枚です。"
 white.delete(key)
 event.send_message(_message)
end

bot.command :start do |event,shadow,raider,citizen|
  i = 0
  shadow = shadow.to_i
  raider = raider.to_i
  citizen = citizen.to_i
  green = {"1"=>"君はシチズンかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"2"=>"君はシチズンかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"3"=>"君はシチズンかレイダーだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"4"=>"君はシチズンかレイダーだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"5"=>"君はレイダーかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"6"=>"君はレイダーかシャドウだね。\nだったら君の装備1つを手番プレイヤーに渡すか、1ダメージ受けたまえ。",
"7"=>"君はレイダーだね。\nだったら1ダメージ受けたまえ。",
"8"=>"君はレイダーだね。\nだったら1ダメージ受けたまえ。",
"9"=>"君はレイダーだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
"10"=>"君はレイダーだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
"11"=>"君はシチズンだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
"12"=>"君はシチズンだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
"13"=>"君は自分のキャラクターカードを手番プレイヤーだけにこっそりと見せたまえ。",
"14"=>"君はHPが12以上だね。\nだったら2ダメージ受けたまえ。",
"15"=>"君はHPが11以下だね。\nだったら1ダメージ受けたまえ。",
"16"=>"君はシャドウだね。\nだったら2ダメージ受けたまえ",
"17"=>"君はシャドウだね。\nだったら1ダメージ回復したまえ。（0ダメージの場合、1ダメージうけたまえ。）",
"18"=>"君はシャドウだね。\nだったら1ダメージ受けたまえ。",
"19"=>"君はシャドウだね。\nだったら『女王の陛下の飛行船』に乗りたまえ。\n（今いる場合は1ダメージ受けたまえ。）",
"20"=>"君はシャドウだね。\nだったら2ダメージ受けたまえ"}

 black = {"1"=>"「死神のスコープ」

【装備】

あなたの攻撃レンジは+1される",
"2"=>"「死神のスコープ」

【装備】

あなたの攻撃レンジは+1される",

"3"=>"「オリバーの子分」
　
【使い捨て】
　
他のプレイヤーが所持している任意の装備カードを1つ獲得する",
"4"=>"「オリバーの子分」
　
【使い捨て】

他のプレイヤーが所持している任意の装備カードを1つ獲得する",

"5"=>"「オリバーの子分」
　
【使い捨て】
　
他のプレイヤーが所持している任意の装備カードを1つ獲得する",
"6"=>"「三つ目の黒犬」

【使い捨て】　

あなたと、あなた以外の任意のプレイヤー1人に2ダメージずつ与える",
"7"=>"「三つ目の黒犬」

【使い捨て】　

あなたと、あなた以外の任意のプレイヤー1人に2ダメージずつ与える",
"8"=>"「吸血コウモリ」

【使い捨て】　

あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
"9"=>"「吸血コウモリ」

【使い捨て】　

あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
"10"=>"「吸血コウモリ」

【使い捨て】
　
あなた以外の任意のプレイヤー1人に2ダメージを与える。あなたは1ダメージ回復する。",
"11"=>"「ガトリング」

【装備】　

あなたの攻撃は、攻撃可能レンジにいるすべてのプレイヤーに対して行われる。(ダイスは1度だけ振り、それを全員に適用する)",
"12"=>"「拳銃【L】」

【装備】　

あなたの攻撃が成功したとき、ダメージが1増加する。",
"13"=>"「拳銃【R】」

【装備】
　
あなたの攻撃が成功したとき、ダメージが1増加する。",
"14"=>"「サーベル」

【装備】　

あなたの攻撃が成功したとき、ダメージが1増加する。",
"15"=>"「クロスボウガン」

【装備】　

あなたの攻撃が成功したとき、ダメージが1増加する。",
"16"=>"「妖刀マサムネ」

【装備】

あなたは攻撃可能なレンジに他のプレイヤーがいる限り必ず攻撃を行わなければならない。この攻撃は4面ダイスのみを使用し、その出目と同数の攻撃ダメージを与える。",
"17"=>"「バナナの皮」

【使い捨て】　

あなたが所持している任意の装備1つを、他の任意のプレイヤーに渡す。装備を持っていない場合、あなたは1ダメージを受ける。",
"18"=>"「暴動」

【使い捨て】　

ダイスを振り、出目に対応したエリアカードにいる全てのプレイヤーに3ダメージを与える。(10の場合は何も起こらない)",
"19"=>" 「戦慄の闇儀式」

【使い捨て】　

あなたがシャドウの場合、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。",
"20"=>"「呪いの人形」

【使い捨て】　

他のプレイヤー1人を選び6面ダイスを振る。出目が1~4の場合は選ばれたプレイヤーが、5~6の場合はあなたが3ダメージを受ける。"
}


white = {"1"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",
"2"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",

"3"=>"「いやしの聖水」

【使い捨て】

あなたのダメージを2回復する。",
"4"=>"「銀のロザリオ」
　
【装備】

あなたの攻撃によって他のプレイヤーが脱落したとき、そのプレイヤーの所持していた装備カードを全て獲得する。",

"5"=>"「銀のロザリオ」
　
【装備】
　
あなたの攻撃によって他のプレイヤーが脱落したとき、そのプレイヤーの所持していた装備カードを全て獲得する。",
"6"=>"「幸運のブローチ」

【装備】　

あなたはエリアカード【市庁舎】の効果によるダメージを受けない。(回復は行える)",
"7"=>"「賢者のローブ」

【装備】　

あなたが行った攻撃のダメージが1減少する。あなたに対して行われた攻撃のダメージが1減少する。(この結果1ダメージが0ダメージになった場合、攻撃失敗になる)",
"8"=>"「神秘のコンパス」

【装備】　

あなたが移動するとき、ダイスを二度振り、どちらかの出目を選んで移動する。",
"9"=>"「虹色のパラソル」

【装備】　

あなたは攻撃を行う代わりに、推理カードを1枚引いてただちにレンジ内にいるプレイヤーに対して使用することができる。",
"10"=>"「いにしえの聖杯」

【装備】
　
あなたは黒のカード【三つ目の黒犬】【吸血コウモリ】【呪いの人形】によるダメージを受けない。",
"11"=>"「エクスカリバー」

【装備】　

あなたの攻撃が成功したとき、あなたがレイダーであれば正体を公開してもよい。公開した場合、ダメージが2増加する。",
"12"=>"「守護天使」

【使い捨て】　

次のあなたの手番の最初まで、あなたは攻撃によるダメージを受けない。",
"13"=>"「裁きの閃光」

【使い捨て】
　
あなた以外のプレイヤーは全員2ダメージを受ける。",
"14"=>"「人魚の涙」

【使い捨て】　

現在最もダメージの大きいプレイヤーのダメージを3回復する。(該当するプレイヤーが複数いる場合はその全員が回復)",
"15"=>"「恩恵」

【使い捨て】　

あなた以外のプレイヤー1人を選び、6面ダイスを振る。そのプレイヤーは出目と同数のダメージを回復する。",
"16"=>"「闇を祓う鏡」

【使い捨て】

あなたがウラヌス/アルスター/ヴァンパイア/復讐の女神/ベノム/狼男/ワルプルギス/ワイトのとき、あなたは自分の正体を公開しなければならない。",
"17"=>"「応急手当」

【使い捨て】　

任意のプレイヤー1人のダメージを7にする。(あなた自身を選んでもよい)",
"18"=>"「光臨」

【使い捨て】　

あなたがレイダーの場合、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。",
"19"=>" 「封印の知恵」

【使い捨て】　

この手番の終了後、もう一度あなたの手番を行う。",
"20"=>"「幸せのクッキー」

【使い捨て】　

あなたがアリス/アンジェラ/アガサ/ウルリッヒ/ウラヌス/アルスター/のとき、正体を公開してもよい。公開した場合、あなたは全てのダメージを回復する。"
}
  num = shadow+raider+citizen
  array = s.sample(shadow)+r.sample(raider)+c.sample(citizen)
  your_board = array.shuffle.freeze
  event.respond "シャドウ:　#{shadow}人\nレイダー:　#{raider}人\nシチズン:　#{citizen}人\nで始めて良いですか？\nbotへのDMで「select」と入力すると、キャラクターが選ばれます。
  人数の変更やゲームをもう一度やり直したい場合は「start x y z」してください"
end

bot.command :select do |event|
  i += 1
  if i > num
    event.send_message("指定した人数以上のキャラクターが選ばれました。\n人数を変更する場合や、ゲームをリセットするときは\nstart x y z\nと入力してください")
    break;
  end
 event.send_message("あなたのキャラクターは#{your_board[i-1]}です。\n\n詳細を知りたい場合は\nwhat #{your_board[i-1]}\nと入力してください。\n\nあなたの順番は#{i}番目です。\n\nキャラクターをあと#{num-i}人選んでください。")
end

bot.run
