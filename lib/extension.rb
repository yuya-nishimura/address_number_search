# レコードへの変換メソッドを拡張する
# class Array
#   # CSVの行から必要なものだけを取り出した配列を作る
#   def to_record
#     [self[2], *self[6..8]] # [郵便番号, 都道府県名, 市町村区名, 町域]
#   end
# end

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
