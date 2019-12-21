require "minitest/autorun"
require_relative "../lib/search.rb"

require "json"

# searchメソッドのテスト
class SearchTest < Minitest::Test
  hash = {}
  INDEX_PATH = File.expand_path("../index.json", __dir__)

  def test_search
    File.open(INDEX_PATH) do |f|
      hash = JSON.load(f)
    end
    assert_equal [124351, 124352], hash.keys.slice(0..5)
  end
end