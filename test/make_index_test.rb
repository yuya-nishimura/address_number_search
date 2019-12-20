require "minitest/autorun"
require_relative "../lib/extension"
require_relative "../lib/make_index"

# make_indexメソッドで使われる他メソッドのテスト
class MakeIndexTest < Minitest::Test
  # サンプル
  SAMPLE_ROW_1 = %w[東京都 杉並区 本天沼]
  SAMPLE_ROW_2 = %w[東京都 中野区 中野]
  SAMPLE_QUERIES_1 = %w[東京 京都 杉並 並区 本天 天沼]
  SAMPLE_QUERIES_2 = %w[東京 京都 中野 野区]
  SAMPLE_HASH_1 = { "東京" => [0], "京都" => [0],
                    "杉並" => [0], "並区" => [0],
                    "本天" => [0], "天沼" => [0] }
  SAMPLE_HASH_2 = { "東京" => [0, 1], "京都" => [0, 1],
                    "杉並" => [0], "並区" => [0],
                    "本天" => [0], "天沼" => [0],
                    "中野" => [1], "野区" => [1] }

  # create_queriesメソッドのテスト
  def test_create_queries
    # Array#to_queriesで正しく分割される
    assert_equal SAMPLE_QUERIES_1, create_queries(SAMPLE_ROW_1)
    # 重複が削除される
    assert_equal SAMPLE_QUERIES_2, create_queries(SAMPLE_ROW_2)
  end

  # update_indexメソッドのテスト
  def test_update_index
    index_hash = {}
    sample_query_arr = [SAMPLE_QUERIES_1, SAMPLE_QUERIES_2]

    # サンプルのクエリ配列から期待されるハッシュが返る
    update_index(index_hash, sample_query_arr[0], 0)
    assert_equal(SAMPLE_HASH_1, index_hash)

    # 2つ目
    update_index(index_hash, sample_query_arr[1], 1)
    assert_equal(SAMPLE_HASH_2, index_hash)
  end
end
