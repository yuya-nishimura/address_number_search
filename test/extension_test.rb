require "minitest/autorun"
require_relative "../lib/extension.rb"

# 拡張メソッドのテスト
class ExtensionTest < Minitest::Test
  # サンプル
  SAMPLE_STRING = "鳥取県鳥取市覚寺"
  SAMPLE_BIGRAM = %w[鳥取 取県 県鳥 鳥取 取市 市覚 覚寺]

  def test_to_bigram
    # バイグラムへの変換が期待通りに行われるか
    assert_equal SAMPLE_BIGRAM, SAMPLE_STRING.to_bigram
  end
end
