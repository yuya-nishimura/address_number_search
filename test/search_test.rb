require "minitest/autorun"
require_relative "../lib/search.rb"
require_relative "../lib/extension.rb"

require "json"
require "csv"

# searchメソッドのテスト
class SearchTest < Minitest::Test
  INDEX_PATH = File.expand_path("../index.json", __dir__)
  DATASRC_PATH = File.expand_path("../src/KEN_ALL.CSV", __dir__)
  SAMPLE_QUERIES = %w[宮城 城県 仙台 台市 市青 青葉 葉区 花京 京院]
  SAMPLE_INDEX_HASH = { "address_number" => "9800013",
                        "prefecture" => "宮城県",
                        "city" => "仙台市青葉区",
                        "town_area" => "花京院",
                        "queries" => SAMPLE_QUERIES }
  SAMPLE_RESULT = "9800013,宮城県,仙台市青葉区,花京院"

  # クエリ配列のテスト
  # def test_queries
  #   input1 = "東京"
  #   input2 = "鳥取県鳥取市"
  #   queries1 = input1.to_bigram
  #   queries1.uniq!
  #   queries2 = input2.to_bigram
  #   queries2.uniq!
  #   assert_equal queries1, %w[東京]
  #   assert_equal queries2, %w[鳥取 取県 県鳥 取市]
  # end

  # parse_indexメソッドのテスト
  def test_parse_index
    index_hash = parse_index(INDEX_PATH)
    assert_equal SAMPLE_INDEX_HASH, index_hash["records_with_queries"][12_863]
  end

  # record_matched?メソッドのテスト
  def test_record_matched?
    assert record_matched? SAMPLE_INDEX_HASH, "宮城県".to_bigram
    assert record_matched? SAMPLE_INDEX_HASH, "仙台市青葉区".to_bigram
    assert record_matched? SAMPLE_INDEX_HASH, "花京院".to_bigram
    assert !record_matched?(SAMPLE_INDEX_HASH, "花京院典明".to_bigram)
  end

  # convert_to_resultメソッドのテスト
  def test_convert_to_result
    assert_equal SAMPLE_RESULT, convert_to_result(SAMPLE_INDEX_HASH)
  end
  # fetch_row_numbersメソッドのテスト
  # def test_fetch_row_numbers
  #   assert_equal [0, 1], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[東京 京都])
  #   assert_equal [0], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[本天 天沼])
  #   assert_equal [1], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[中野 野区])
  #   assert_equal [], fetch_row_numbers(SAMPLE_INDEX_HASH, %w[ほげ ほげ])
  # end

  # # search_resultsメソッドのテスト
  # def test_search_results
  #   records = CSV.readlines(DATASRC_PATH, encoding: "SJIS:UTF-8")
  #   expected_str1 = "0600010,北海道,札幌市中央区,北十条西"
  #   expected_str2 = "0140368,秋田県,仙北市,角館町中菅沢"
  #   expected_results = [expected_str1, expected_str2]
  #   assert_equal expected_results, search_results(records, [26, 18_083])
  # end
end
