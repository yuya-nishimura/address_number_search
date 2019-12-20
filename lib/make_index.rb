# インデックスファイル作成メソッド
def make_index
  # 作成するインデックス用のハッシュ
  hash_for_index = {}

  # データソースのCSVを開く
  # encodingオプションは内部及び外部のエンコーディングを指定する
  CSV.foreach(DATASRC_PATH, encoding: "SJIS:UTF-8") do |row|
    # 行数を取り出す
    row_num = $.

    # 都道府県名、市町村区名、町域を取り出しそれを元にクエリ配列を作る
    address_elements = row.slice(6..8)
    queries = create_queries(address_elements)

    # クエリ配列と行数を元にインデックスハッシュを更新する
    update_index(hash_for_index, queries, row_num)
  end

  # ハッシュをJSONに書き出す
  File.open(INDEX_PATH, "w") do |f|
    json = JSON.dump(hash_for_index)
    f.write(json)
  end
end

# 都道府県名、市町村区名、町域を分割し検索用のクエリ配列を作るメソッド
def create_queries(address_elements)
  # クエリ配列
  queries = []

  # 各要素をバイグラムに変換してクエリ配列に入れる
  address_elements.each do |address_element|
    queries << address_element.to_bigram
  end

  # バイグラムの配列になっているのを平坦化し、重複を取り除く
  queries.flatten.uniq
end

# クエリ配列と行数を元にインデックスを更新するメソッド
def update_index(hash, queries, row_num)
  queries.each do |query|
    hash[query] ||= [] # 配列で初期化
    hash[query] << row_num # 行数を配列としてまとめていく
  end
end
