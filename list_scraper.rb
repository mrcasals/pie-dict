class ListScraper
  URL_PREFIX = "https://en.wiktionary.org"

  def initialize(url)
    @url = url
  end

  def elements
    clean_body.css("li").map do |element|
      "#{URL_PREFIX}/wiki/#{element.text}"
    end
  end

  def next_page_url
    link = page_body.css("a[title='Category:Proto-Indo-European lemmas']").select{|e| e.text == "next page"}.first
    return unless link

    "#{URL_PREFIX}#{link.attributes["href"].value}"
  end

  private

  attr_reader :url

  def clean_body
    @clean_body ||= page_body.css("#mw-pages .mw-content-ltr")
  end

  def page_body
    @page_body ||= Nokogiri::HTML(dirty_response_body)
  end

  def dirty_response_body
    @dirty_response_body = HTTParty.get(url).body
  end
end
