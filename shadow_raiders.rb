require "bundler/setup"
require 'discordrb'
require 'json'
require 'dotenv'

Dotenv.load

TOKEN = ENV["TOKEN"]
CLIENT_ID = ENV["CLIENT_ID"]

bot = Discordrb::Commands::CommandBot.new token: TOKEN , client_id: CLIENT_ID,prefix: ''

your_board = []
number_of_people = 0
i = 0

def set_board(x,y,z)

  s = ["ウラヌス","ウルリッヒ","ワルプルギス","ワイト","復讐の女神","アルスター","ヴァンパイア","狼男","ベノム"]
  r = ["エミ","エリカ","フェリックス","ガラハド","フレディ","エマ","ゴドウィン","フェリシア","ゴードン"]
  c = ["アリス","アガサ","デーヴィッド","ベンジャミン","バイロン","デボラ","アンジェラ","キャロル","クレイグ","クレア","ブルース","ダニエル"]

  array = s.sample(x.to_i)+r.sample(y.to_i)+c.sample(z.to_i)
  board = array.shuffle.freeze

  board
end

def set_cards(color)
  File.open("#{color}.json") do |file|
  cards = JSON.load(file)
  cards
  end
end


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

green = set_cards("green")

bot.command :g do |event|
if green.length == 0
  green = set_cards("green")
end

# sample は配列の中からランダムな値を取り出すメソッド

key = green.keys.sample
_message = "#{green[key]}\n\n推理カードは残り#{green.length-1}枚です。"
 green.delete(key)
event.send_message(_message)
end

black = set_cards("black")

bot.command :b do |event|
if black.length == 0
  black = set_cards("black")
end

key = black.keys.sample
_message = "#{black[key]}\n\n黒のカードは残り#{black.length-1}枚です。"
 black.delete(key)
 event.send_message(_message)
end

white = set_cards("white")

bot.command :w do |event|
if white.length == 0
white = set_cards("white")
end

key = white.keys.sample
_message = "#{white[key]}\n\n白のカードは残り#{white.length-1}枚です。"
 white.delete(key)
 event.send_message(_message)
end

bot.command :start do |event,x,y,z|

  if x.to_i > 9 || y.to_i > 9 || z.to_i > 12
     event.respond "指定された人数が多すぎます。\nシャドウ9人\nレイダー9人\nシチズン12人\nまでで指定してください。"
    return
  end

  i = 0

  green = set_cards("green")
  black = set_cards("black")
  white = set_cards("white")

  number_of_people = x.to_i + y.to_i + z.to_i
  your_board = set_board(x,y,z)

  event.respond "シャドウ:　#{x}人\nレイダー:　#{y}人\nシチズン:　#{z}人\nで始めて良いですか？\nbotへのDMで「select」と入力すると、キャラクターが選ばれます。
  人数の変更やゲームをもう一度やり直したい場合は\n「start x y z」\nしてください。"
end

bot.command :select do |event|
  i += 1
  if i > number_of_people
    event.send_message("指定した人数以上のキャラクターが選ばれました。\n人数を変更する場合や、ゲームをリセットするときは\nstart x y z\nと入力してください")
    return;
  end
 event.send_message("あなたのキャラクターは#{your_board[i-1]}です。\n\n詳細を知りたい場合は\nwhat #{your_board[i-1]}\nと入力してください。\n\nあなたの順番は#{i}番目です。\n\nキャラクターをあと#{number_of_people - i}人選んでください。")
end

bot.run
