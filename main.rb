require("csv")

INDEX_PATH = File.expand_path("../index.csv", __FILE__)

unless File.exist?(INDEX_PATH)
  puts "インデックスファイルがありません"
  exit
end


# 配列を拡張し判定用メソッドを追加する
class Array
  # 住所が与えられたクエリ配列に対しマッチするか判定する
  def address_matched?(queries)
    # 都道府県名、市町村区名、町域それぞれに対しクエリをループさせて判定する
    self.each do |address_elem|
      queries.each do |query|
        # どれか一つでもマッチした時点で処理を止める
        if address_elem.include?(query)
          return true
        end
      end
    end
  end
end

puts "検索ワードを入力して下さい"

# 入力された文字列から空白を取り除く
# input = gets.gsub!(/\s+/, "")

input = "東京都中野区"
# 文字列を分割し検索用のクエリ配列を作る
queries = []
input.chars.each_cons(2) do |word|
  queries << word.join("")
end

# インデックスファイルを開きクエリで検索する
CSV.foreach(INDEX_PATH, encoding: "UTF-8") do |row|
  puts row.join(",") if row[1..3].address_matched?(queries)
end