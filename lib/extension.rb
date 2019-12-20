class Array
  # 住所が与えられたクエリ配列に対しマッチするか判定する
  def address_matched?(queries)
    # 都道府県名、市町村区名、町域それぞれに対しクエリをループさせて判定する
    each do |address_elem|
      queries.each do |query|
        # どれか一つでもマッチした時点でtrueを返し、処理を止める
        address_elem.include?(query) && true
      end
    end
    # 何処にも引っかからなかった場合はfalseを返す
    false
  end

  # 配列を分割し検索用のクエリ配列を作る
  def to_queries
    queries = []

    # 各要素を二文字ずつに分割してクエリ配列に入れる
    each do |address_elem|
      address_elem.chars.each_cons(2) do |word|
        queries << word.join
      end
    end

    # クエリの重複をなくして返す
    queries.uniq
  end
end

# バイグラムへの変換メソッドを拡張する
class String
  # 任意の文字列を二文字ずつ切り取り配列にして返す
  def to_bigram
    bigram = []
    chars.each_cons(2) do |two_chars|
      bigram << two_chars.join
    end
    bigram
  end
end
