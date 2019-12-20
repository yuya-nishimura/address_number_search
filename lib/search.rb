# 検索用メソッド
def search(input)
  # 入力された文字列から空白を取り除く
  input.gsub!(/\s+/, "")

  # 文字列を分割し検索用のクエリ配列を作る
  queries = []
  input.chars.each_cons(2) do |word|
    queries << word.join
  end

  # クエリの重複をなくす
  queries.uniq!

  # インデックスファイルを開きクエリで検索し、マッチしたものを表示していく
  CSV.foreach(INDEX_PATH, encoding: "UTF-8") do |row|
    puts row.join(",") if row[1..3].address_matched?(queries)
  end
end
