# 配列を拡張し判定用メソッドを追加する
class Array
  # 住所が与えられたクエリ配列に対しマッチするか判定する
  def address_matched?(queries)
    # 都道府県名、市町村区名、町域それぞれに対しクエリをループさせて判定する
    self.each do |address_elem|
      queries.each do |query|
        # どれか一つでもマッチした時点でtrueを返し、処理を止める
        if address_elem.include?(query)
          return true
        end
      end
    end
    # 何処にも引っかからなかった場合はfalseを返す
    return false
  end
end

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

