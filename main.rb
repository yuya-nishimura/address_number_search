# ライブラリ読み込み
require("csv")

# 各CSVファイルのパス
INDEX_PATH = File.expand_path("../index.csv", __FILE__)
DATASRC_PATH = File.expand_path("../src/KEN_ALL.CSV", __FILE__)

# /libに配置したファイルを読み込み
require_relative("./lib/make_index")
require_relative("./lib/search")

loop do
  puts <<~TEXT
        -------------------------
        1. インデックスファイル作成
        2. 住所レコード検索
        3. 終了

        半角数字を入力して下さい(1~3)
        -------------------------
    TEXT

  selected_num = gets.chomp

  case selected_num
  when "1"
    make_index
  when "2"
    search
  when "3"
    exit
  else
    puts "1~3の半角数字を入力して下さい"
  end
end