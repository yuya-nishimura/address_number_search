require "csv"
require "json"

INDEX_CSV = File.expand_path("../index.csv", __dir__)
INDEX_JSON = File.expand_path("../index.json", __dir__)

puts "開始"
csv = CSV.read(INDEX_CSV, headers: true)
str = File.read(INDEX_JSON)
JSON.parse(str)
puts csv.class
puts "終了"
