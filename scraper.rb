require "nokogiri"
require "httparty"
require "byebug"
require "json"

require_relative "lib/scraper"

url = "https://en.wiktionary.org/wiki/Category:Proto-Indo-European_lemmas"

errored = []

loop do
  list_scraper = ListScraper.new(url)
  list_scraper.lemma_urls.each do |lemma_url|
    sleep 0.2

    if result = LemmaScraper.parse(lemma_url)
      File.open("data/#{result[:lemma]}.json", "w") {|f| f.write(JSON.pretty_generate(result))}
      print "."
    else
      errored << {
        url: lemma_url,
        reason: :cant_validate
      }
    end
  rescue => e
    errored << {
      url: lemma_url,
      reason: :exception
    }
  end
  url = list_scraper.next_page_url
  break unless url
end

errors_file_path = "errors.json"
if errored.any?
  pp errored
  File.open(errors_file_path, "w") {|f| f.write(JSON.pretty_generate(errored))}
else
  File.delete(errors_file_path) if File.exist?(errors_file_path)
  puts ""
  puts "Yay! All parsed correctly!"
end
