require "minitest/autorun"
require_relative "../lib/search.rb"
require_relative "../lib/extension.rb"

require "json"
require "csv"

# searchメソッドのテスト
class SearchTest < Minitest::Test
  INDEX_PATH = File.expand_path("../index.json", __dir__)
  DATASRC_PATH = File.expand_path("../src/KEN_ALL.CSV", __dir__)
  SAMPLE_INDEX_HASH = { "東京" => [0, 1], "京都" => [0, 1],
                        "杉並" => [0], "並区" => [0],
                        "本天" => [0], "天沼" => [0],
                        "中野" => [1], "野区" => [1] }

  # クエリ配列のテスト
  def test_queries
    input1 = "東京"
    input2 = "鳥取県鳥取市"
    queries1 = input1.to_bigram
    queries1.uniq!
    queries2 = input2.to_bigram
    queries2.uniq!
    assert_equal queries1, %w[東京]
    assert_equal queries2, %w[鳥取 取県 県鳥 取市]
  end

  # parse_indexメソッドのテスト
  def test_parse_index
    index_hash = parse_index(INDEX_PATH)
    assert_equal [124_351, 124_352], index_hash["那国"] # インデックスが巨大なのでここだけテスト
  end

  # fetch_row_numbersメソッドのテスト
  def test_fetch_row_numbers
    assert_equal [0, 1], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[東京 京都])
    assert_equal [0], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[本天 天沼])
    assert_equal [1], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[中野 野区])
    assert_equal [], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[ほげ ほげ])
  end

  # search_resultsメソッドのテスト
  def test_search_results
    records = CSV.readlines(DATASRC_PATH, encoding: "SJIS:UTF-8")
    expected_str1 = "0600010,北海道,札幌市中央区,北十条西"
    expected_str2 = "0140368,秋田県,仙北市,角館町中菅沢"
    expected_results = [expected_str1, expected_str2]
    assert_equal expected_results, search_results(records, [26, 18_083])
  end
end
