# ライブラリ読み込み
require("csv")
require("json")

# 各CSVファイルのパス
INDEX_PATH = File.expand_path("../index.json", __FILE__)
DATASRC_PATH = File.expand_path("../src/KEN_ALL.CSV", __FILE__)

# /libに配置したファイルを読み込み
require_relative("./lib/extension")
require_relative("./lib/make_index")
require_relative("./lib/search")

# ユーザーにオプションを選択させ、各機能を実行という流れを1セットとしてループする
loop do
  puts <<~TEXT
        -----------------------------
        1. インデックスファイル作成
        2. 住所レコード検索
        3. 終了

        半角数字を入力して下さい(1~3)
        -----------------------------
    TEXT

  selected_num = gets.chomp

  case selected_num
  when "1" # インデックスファイル作成
    make_index
    puts "作成が完了しました"
  when "2" # 住所レコード検索
    # インデックスファイルが無ければ終了
    unless File.exist?(INDEX_PATH)
      puts "インデックスファイルがありません"
      next
    end

    # インデックスファイルがあれば、入力された文字列で検索
    puts "検索ワードを入力して下さい"
    search(gets.chomp)
  when "3" #終了
    puts "終了します"
    exit
  else
    puts "1~3の半角数字を入力して下さい"
  end
end