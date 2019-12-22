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
