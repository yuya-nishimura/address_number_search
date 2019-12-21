# 検索用メソッド
def search(input)
  # 文字列を分割し検索用のクエリ配列を作り、重複をなくす
  queries = input.to_bigram
  queries.uniq!

  # インデックスファイルを開きクエリで検索し、マッチしたものを表示していく
  CSV.foreach(INDEX_PATH, encoding: "UTF-8") do |row|
    puts row.join(",") if row[1..3].address_matched?(queries)
  end
end
