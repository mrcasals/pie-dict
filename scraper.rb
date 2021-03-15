require "nokogiri"
require "httparty"
require "byebug"

class Scraper
  URL_PREFIX = "https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/"

  def self.parse(url)
    new(url).parse
  end

  def initialize(url)
    @url = url
  end

  def parse
    if !valid_scraper_for_page?
      puts "============"
      puts "Please, find a better scraper for lemma: #{lemma}"
      puts "============"
      return
    end

    pp data
  end

  private

  attr_reader :url

  def data
    {
      lemma: lemma,
      etymology: etymology,
      klass: lemma_klass,
      markers: markers,
      definitions: definitions,
      topics: topics
    }
  end

  def lemma
    text = body.css("h1.firstHeading span").text
    "*#{text}"
  end

  def etymology_header
    @etymology_header ||= body.css("#Etymology").first.parent
  end

  def etymology_element
    @etymology_element ||= etymology_header.next_element
  end

  def etymology
    etymology_element.text.chomp
  end

  def lemma_klass_element
    @lemma_klass_element ||= etymology_element.next_element
  end

  def lemma_klass
    lemma_klass_element.text.delete_suffix("[edit]").downcase
  end

  def lemma_with_markers_element
    @lemma_with_markers_element ||= lemma_klass_element.next_element
  end

  def markers
    lemma_with_markers_element.css("abbr").map do |abbr|
      [abbr.text, abbr.attribute("title").text]
    end.to_h
  end

  def definitions_list
    @definitions_list ||= lemma_with_markers_element.next_element
  end

  def definitions
    definitions_list.css("li").map(&:text)
  end

  def topics
    body
      .css("#mw-normal-catlinks ul")
      .first
      .children
      .select { |element| element.text =~ /^ine-pro:/ }
      .map(&:text)
  end

  def valid_scraper_for_page?
    body.css("#toc a").map(&:text).join(" ").include?("1.3 References")
  end

  def body
    @body ||= Nokogiri::HTML(dirty_response_body)
  end

  def dirty_response_body
    @dirty_response_body = HTTParty.get(url).body
  end
end

# Single definition
Scraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/%C7%B5%CA%B0h%E2%82%82%C3%A9ns")
# 2 definitions in a single lemma
Scraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/d%E1%B9%93m")
# "Reconstruction" section before the definition
Scraper.parse("https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/h%E2%82%82%C3%A9nts")
