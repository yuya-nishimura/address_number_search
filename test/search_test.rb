require "minitest/autorun"
require_relative "../lib/search.rb"
require_relative "../lib/extension.rb"

require "json"
require "csv"

# searchメソッドのテスト
class SearchTest < Minitest::Test
  INDEX_PATH = File.expand_path("../index.json", __dir__)
  SAMPLE_INDEX_HASH = { "address_number" => "9800013",
                        "prefecture" => "宮城県",
                        "city" => "仙台市青葉区",
                        "town_area" => "花京院",
                        "queries" => SAMPLE_QUERIES }
  SAMPLE_RESULT = "9800013,宮城県,仙台市青葉区,花京院"

  # parse_indexメソッドのテスト
  def test_parse_index
    index_hash = parse_index(INDEX_PATH)
    assert_equal SAMPLE_INDEX_HASH, index_hash["records_with_queries"][12_547]
  end

  # record_matched?メソッドのテスト
  def test_record_matched?
    assert record_matched? SAMPLE_INDEX_HASH, "宮城県".to_bigram
    assert record_matched? SAMPLE_INDEX_HASH, "仙台市青葉区".to_bigram
    assert record_matched? SAMPLE_INDEX_HASH, "宮城県仙台市青葉区花京院".to_bigram
    assert !record_matched?(SAMPLE_INDEX_HASH, "花京院典明".to_bigram)
  end

  # convert_to_resultメソッドのテスト
  def test_convert_to_result
    assert_equal SAMPLE_RESULT, convert_to_result(SAMPLE_INDEX_HASH)
  end
end
