require "minitest/autorun"
require_relative "../lib/extension"
require_relative "../lib/make_index"

# make_indexメソッドで使われる他メソッドのテスト
class MakeIndexTest < Minitest::Test
  # サンプル
  SAMPLE_ROW1 = %w[0000 00 1670003 ﾄｳｷｮｳﾄ ｽｷﾞﾅﾐｸ ﾎﾝｱﾏﾇﾏ 東京都 杉並区 本天沼 0 0 0 0 0 0]
  SAMPLE_ROW2 = %w[0000 00 1640001 ﾄｳｷｮｳﾄ ﾅｶﾉｸ ﾅｶﾉ 東京都 中野区 中野 0 0 0 0 0 0]

  SAMPLE_ROW3 = %w[0000 00 1670003 ﾄｳｷｮｳﾄ ｽｷﾞﾅﾐｸ ﾎﾝｱﾏﾇﾏ 東京都 杉並区 本天沼 0 0 0 0 0 0]
  SAMPLE_ROW4 = %w[0000 00 1640001 ﾄｳｷｮｳﾄ ﾅｶﾉｸ ﾅｶﾉ 東京都 中野区 中野 0 0 0 0 0 0]
  SAMPLE_ROW5 = %w[0000 00 1640001 ﾄｳｷｮｳﾄ ﾅｶﾉｸ ﾅｶﾉ 東京都 ほげ区 ほげ 0 0 0 0 0 0]

  SAMPLE_RECORD1 = %w[1670003 東京都 杉並区 本天沼]
  SAMPLE_RECORD2 = %w[1640001 東京都 中野区 中野]

  SAMPLE_QUERIES1 = %w[東京 京都 都杉 杉並 並区 区本 本天 天沼]
  SAMPLE_QUERIES2 = %w[東京 京都 都中 中野 野区 区中]

  SAMPLE_INDEX_HASH1 = {  address_number: "1670003",
                          prefecture: "東京都",
                          city: "杉並区",
                          town_area: "本天沼",
                          queries: %w[東京 京都 都杉 杉並 並区 区本 本天 天沼] }
  SAMPLE_INDEX_HASH2 = {  address_number: "1640001",
                          prefecture: "東京都",
                          city: "中野区",
                          town_area: "中野",
                          queries: %w[東京 京都 都中 中野 野区 区中] }

  # SAMPLE_ROW1 = %w[東京都 杉並区 本天沼]
  # SAMPLE_ROW2 = %w[東京都 中野区 中野]
  # SAMPLE_ARR1 = %w[00000 00 6800003 ﾄｯﾄﾘｹﾝ ﾄｯﾄﾘｼ ｶｸｼﾞ 鳥取県 鳥取市 覚寺 0 0 0 0 0 0]
  # SAMPLE_ARR2 = %w[6800003 鳥取県 鳥取市 覚寺]

  # create_recordメソッドのテスト
  def test_create_record
    assert_equal SAMPLE_RECORD1, create_record(SAMPLE_ROW1)
    assert_equal SAMPLE_RECORD2, create_record(SAMPLE_ROW2)
  end

  # same_record?メソッドのテスト
  def test_same_record?
    assert !same_record?(SAMPLE_ROW3, SAMPLE_ROW4)
    assert same_record?(SAMPLE_ROW4, SAMPLE_ROW5)
  end

  # concat_same_recordsメソッドのテスト
  def test_concat_same_records
    csv = [SAMPLE_ROW3, SAMPLE_ROW4, SAMPLE_ROW5]
    concat_same_records(csv)
    assert_equal "中野ほげ", csv[1][8]
    assert_equal 2, csv.size
  end

  # create_queriesメソッドのテスト
  def test_create_queries
    assert_equal SAMPLE_QUERIES1, create_queries(SAMPLE_RECORD1)
    assert_equal SAMPLE_QUERIES2, create_queries(SAMPLE_RECORD2)
  end

  # create_index_hashメソッドのテスト
  def test_create_index_hash
    record_with_queries1 = create_index_hash(SAMPLE_RECORD1, SAMPLE_QUERIES1)
    record_with_queries2 = create_index_hash(SAMPLE_RECORD2, SAMPLE_QUERIES2)
    assert_equal SAMPLE_INDEX_HASH1, record_with_queries1
    assert_equal SAMPLE_INDEX_HASH2, record_with_queries2
  end
end
