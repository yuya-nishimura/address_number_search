# ライブラリ読み込み
require("csv")

# 各CSVファイルのパス
INDEX_PATH = File.expand_path("../../index.csv", __FILE__)
DATASRC_PATH = File.expand_path("../../src/KEN_ALL.CSV", __FILE__)

# wオプションでファイルの中身をリセット出来る
File.open(INDEX_PATH, "w") do |file|
  # encodingオプションは内部及び外部のエンコーディングを指定する
  CSV.foreach(DATASRC_PATH, encoding: "SJIS:UTF-8") do |row|
    # 必要な要素のみ取り出す
    address_number = row[2]
    prefecture     = row[6]
    city           = row[7]
    town_area      = row[8]

    # 行として出力
    file.write("#{address_number},#{prefecture},#{city},#{town_area}\n")
  end
end