require "minitest/autorun"
require_relative "../lib/search.rb"

require "json"

# searchメソッドのテスト
class SearchTest < Minitest::Test
  INDEX_PATH = File.expand_path("../index.json", __dir__)

  # インデックスのパーステスト
  def test_search
    index_hash = {}
    File.open(INDEX_PATH) do |f|
      index_hash = JSON.load(f)
    end
    assert_equal [124_351, 124_352], index_hash["那国"] # インデックスが巨大なのでここだけテスト
  end
end
