# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

url = 'http://ameblo.jp/' + ENV['AMEBLO_ID_ABU']

charset = nil
html = open(url) do |f|
  charset = f.charset 	# 文字種別を取得
  f.read 		# htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

# ブログタイトルを表示
doc.css('div.recentEntriesMenu').css('ul.skinSubList').each do |title_list|
  puts title_list.css('li')[0].inner_text
  detail = title_list.css('li').css('a')[0][:href]
  
  # 詳細ページの取得
  contents = open(detail) do |blog|
    charset = blog.charset
    blog.read
  end

  # 改行変換
  blog_doc = Nokogiri::HTML.parse(html, nil, charset)
  blog_doc.search('br').each do |br|
    br.replace("\n")
  end

  # 記事の部分のみ取得
  blog_doc.css('div.articleText').each do |blog_contents|
    puts blog_contents.content
  end
end

