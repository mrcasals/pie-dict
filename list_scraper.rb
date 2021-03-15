class ListScraper
  URL_PREFIX = "https://en.wiktionary.org"

  def initialize(url)
    @url = url
  end

  def elements
    pp clean_body.css("li").map(&:text)
  end

  def next_link
    link = page_body.css("a[title='Category:Proto-Indo-European lemmas']").first
    return unless link

    pp "#{URL_PREFIX}#{link.attributes["href"].value}"
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
