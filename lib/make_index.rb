# インデックスファイル作成メソッド
def make_index
  # 作成するインデックスファイル用のハッシュ
  hash_for_index = { records_with_queries: [] }

  # データソースのCSVを読み込む(二次元配列形式になる)
  puts "CSVファイルを読込中..."
  csv = CSV.read(DATASRC_PATH, encoding: "SJIS:UTF-8")

  # 同じレコードとみなせるものは統合する
  puts "重複行を統合中..."
  concat_same_records(csv)

  # 取り出したCSVデータの行ごとにインデックス作成処理を行う
  puts "レコード作成中..."
  csv.each do |row|
    hash_for_index[:records_with_queries] << create_index(row)
  end

  # ハッシュをJSONに書き出す
  File.open(INDEX_PATH, "w") do |f|
    JSON.dump(hash_for_index, f)
  end
end

# CSVの行を一部統合するメソッド
def concat_same_records(csv)
  csv.each_with_index do |row, i|
    next_row = csv[i + 1]
    # 現在の行が次の行と同じレコードの場合統合する
    if same_record?(row, next_row)
      row[8] += next_row[8] # 町域を結合
      csv.delete(i + 1) # 統合された行は消す
    end
  end
end

# CSVの行が複数に跨っているか判定するメソッド
def same_record?(row, next_row)
  next_row && row[2] == next_row[2] # 郵便番号で判定する
end

# CSVの行からインデックスを作成するメソッド
def create_index(row)
  # 行からレコードを作成
  record = create_record(row)

  # レコードからクエリ配列を作成
  queries = create_queries(record)

  # レコードとクエリ配列からインデックスハッシュを作成
  create_index_hash(record, queries)
end

# CSVの行からレコードを生成するメソッド
def create_record(row)
  [row[2], *row[6..8]] # [郵便番号, 都道府県名, 市町村区名, 町域]
end

# 都道府県名、市町村区名、町域を分割し検索用のクエリ配列を作るメソッド
def create_queries(record)
  # 都道府県名から町域までを繋げる
  address = record[1..3].join

  # バイグラムに変換して重複を取り除く
  address.to_bigram.uniq
end

# レコードとクエリ配列を元にインデックスに格納するハッシュを生成するメソッド
def create_index_hash(record, queries)
  keys = %i[address_number prefecture city town_area queries]
  values = [*record, queries]
  keys.zip(values).to_h
end
