require 'nokogiri'
require 'csv'
require 'open-uri'

URL = ARGV[0]
doc = Nokogiri::HTML(open(URL))
table = doc.search(:table)

# CSV形式の文字列を作る
csv_txt = CSV.generate{|csv|
  # table内の各trタグごとに、
  table.search(:tr).each do |tr|
    # その中のthとtdを探して、.textでテキスト部分を取り出す
    csv << tr.search("th,td").map{|tag| tag.text}
  end
}

puts csv_txt
