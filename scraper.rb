require "nokogiri"
require "httparty"
require "byebug"
require "json"

require_relative "list_scraper"
require_relative "lemma_scraper"

# # Single definition
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/%C7%B5%CA%B0h%E2%82%82%C3%A9ns")
# # 2 definitions in a single lemma
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/d%E1%B9%93m")
# # "Reconstruction" section before the definition
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/h%E2%82%82%C3%A9nts")

# Long etymology, synonims
# LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/h%E2%82%81%C3%A9%E1%B8%B1wos")

# =============================
#            TODO
# =============================
# Lemma with 2 different entries
# pp LemmaScraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/seh%E2%82%81-")

url = "https://en.wiktionary.org/wiki/Category:Proto-Indo-European_lemmas"

errored = []

loop do
  list_scraper = ListScraper.new(url)
  list_scraper.lemma_urls.each do |lemma_url|
    sleep 0.2

    if result = LemmaScraper.parse(lemma_url)
      File.open("lemmas/#{result[:lemma]}.json", "w") {|f| f.write(JSON.pretty_generate(result))}
      print "."
    else
      errored << {
        url: lemma_url,
        reason: :cant_validate
      }
    end
  rescue => e
    byebug
    puts lemma_url
    errored << {
      url: lemma_url,
      reason: :exception
    }
  end
  url = list_scraper.next_page_url
  break unless url
end

if errored.any?
  pp errored
else
  puts ""
  puts "Yay! All parsed correctly!"
end
