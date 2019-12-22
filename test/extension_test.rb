require "minitest/autorun"
require_relative "../lib/extension.rb"

# 拡張メソッドのテスト
class ExtensionTest < Minitest::Test
  # サンプル
  SAMPLE_STRING1 = "鳥取県鳥取市覚寺"
  SAMPLE_STRING2 = "覚寺"
  SAMPLE_BIGRAM1 = %w[鳥取 取県 県鳥 鳥取 取市 市覚 覚寺]
  SAMPLE_BIGRAM2 = %w[覚寺]

  # String#to_bigramのテスト
  def test_to_bigram
    # バイグラムへの変換が期待通りに行われるか
    assert_equal SAMPLE_BIGRAM1, SAMPLE_STRING1.to_bigram
    assert_equal SAMPLE_BIGRAM2, SAMPLE_STRING2.to_bigram
  end

  # # Array#to_recordのテスト
  # def test_to_record
  #   assert_equal SAMPLE_ARR2, SAMPLE_ARR1.to_record
  # end
end
