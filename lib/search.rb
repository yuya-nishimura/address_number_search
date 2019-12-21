# 検索用メソッド
def search(input)
  # 文字列を分割し検索用のクエリ配列を作り、重複をなくす
  queries = input.to_bigram
  queries.uniq!

  # インデックスをパース
  index_hash = parse_index(INDEX_PATH)

  # 必要な行数を取得、見つからなければ終了
  row_numbers = fetch_row_numbers(index_hash, queries)
  return puts "該当するレコードは存在しません" if row_numbers.empty?

  # データソースを展開
  puts "CSVを開いています..."
  records = CSV.readlines(DATASRC_PATH, encoding: "SJIS:UTF-8")

  # 結果を表示する
  puts search_results(records, row_numbers)
end

# インデックスのJSONをパースするメソッド
def parse_index(index_path)
  puts "インデックスを開いています..."
  index_hash = {}
  File.open(index_path) do |f|
    index_hash = JSON.load(f)
  end
  index_hash
end

# クエリ配列からインデックスを検索し取り出すべき行数をまとめるメソッド
def fetch_row_numbers(index_hash, queries)
  puts "インデックスを検索しています..."
  # インデックスから、キーがクエリにマッチする値を取り出す(行数の配列)
  row_numbers = []
  queries.each do |query|
    row_numbers << index_hash[query]
  end
  # 該当する行数を一つの配列にまとめる
  row_numbers.flatten.compact.uniq
end

# 結果表示用の配列を返すメソッド
def search_results(records, row_numbers)
  puts "結果を表示します..."
  results = []
  # 該当する行から郵便番号、都道府県名、市町村区名、町域を出力する
  row_numbers.each do |row_number|
    record = records[row_number - 1] # 配列オブジェクトとして読み込んだので1行ズレている
    results << record[2] + "," + record[6..8].join(",")
  end
  results
end
