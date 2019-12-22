# インデックスファイル作成メソッド
def make_index
  # 作成するインデックスファイル用のハッシュ
  hash_for_index = { records_with_queries: [] }

  # データソースのCSVを読み込む(二次元配列形式になる)
  csv = CSV.read(DATASRC_PATH, encoding: "SJIS:UTF-8")

  # 取り出したCSVデータの行ごとにインデックス作成処理を行う
  csv.each do |row|
    # 行からレコードを作成
    record = create_record(row)

    # レコードからクエリ配列を作成
    queries = create_queries(record)

    # レコードとクエリ配列からインデックスハッシュを作成し格納
    index_hash = create_index_hash(record, queries)
    hash_for_index[:records_with_queries] << index_hash
  end

  # ハッシュをJSONに書き出す
  File.open(INDEX_PATH, "w") do |f|
    JSON.dump(hash_for_index, f)
  end
end

# CSVの行からレコードを生成するメソッド
def create_record(row)
  [row[2], *row[6..8]] # [郵便番号, 都道府県名, 市町村区名, 町域]
end

# 都道府県名、市町村区名、町域を分割し検索用のクエリ配列を作るメソッド
def create_queries(record)
  # クエリ配列
  queries = []

  # 各要素をバイグラムに変換してクエリ配列に入れる
  record[1..3].each do |address_element|
    queries << address_element.to_bigram
  end

  # バイグラムの配列になっているのを平坦化し、重複を取り除く
  queries.flatten.uniq
end

# レコードとクエリ配列を元にインデックスに格納するハッシュを生成するメソッド
def create_index_hash(record, queries)
  keys = %i[address_number prefecture city town_area queries]
  values = record << queries
  keys.zip(values).to_h
end
