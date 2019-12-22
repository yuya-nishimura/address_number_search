# 検索用メソッド
def search(input)
  # インデックスをパースしレコード配列を取り出す
  puts "インデックスを開いています..."
  index_hash = parse_index(INDEX_PATH)
  records_with_queries = index_hash["records_with_queries"]

  # 入力された文字列を分割し検索用のクエリ配列を作り、重複をなくす
  search_queries = input.to_bigram.uniq

  # 該当するレコードを一覧表示する。見つからなければ終了
  puts "検索中..."
  results = []
  records_with_queries.each do |record_with_queries|
    # レコードが検索用クエリにマッチしていれば検索結果に格納
    if record_matched?(record_with_queries, search_queries)
      # レコードを結果表示用の文字列に変換して格納
      results << convert_to_result(record_with_queries)
    end
  end

  # 結果を表示する
  puts !results.empty? ? results : "該当するレコードは存在しません"
end

# インデックスのJSONをパースするメソッド
def parse_index(index_path)
  json_str = File.read(index_path)
  JSON.parse(json_str)
end

# レコードが検索用クエリ配列にマッチするか判定するメソッド
def record_matched?(record, search_queries)
  # レコードが持つクエリ配列が検索用クエリ配列を包含しているかを判定する
  record_queries = record["queries"]
  (search_queries - record_queries).empty?
end

# レコードを結果表示用の文字列に変換するメソッド
def convert_to_result(record)
  [
    record['address_number'],
    record['prefecture'],
    record['city'],
    record['town_area']
  ].join(",")
end
