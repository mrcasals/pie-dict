class LemmaScraper
  URL_PREFIX = "https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/"

  def self.parse(url)
    new(url).parse
  end

  def initialize(url)
    @url = url
  end

  def parse
    if validate_sections!
      data
    else
      puts "\nCouldn't validate sections for lemma: #{lemma}"
      false
    end
  end

  private

  attr_reader :url

  def validate_sections!
    page_body.css("#toc ul ul li").count == sections.count
  end

  def data
    {
      lemma: lemma,
      etymology: etymology,
      klass: lemma_klass,
      markers: markers,
      definitions: definitions,
      synonyms: synonyms,
      topics: topics
    }
  end

  def lemma
    text = page_body.css("h1.firstHeading span").text
    "*#{text}"
  end

  def etymology
    current_section = find_section("Etymology")
    return unless current_section

    current_section[:content].map(&:text)
  end

  def lemma_klass
    klass_section[:title]
  end

  def markers
    klass_section[:content].first.css("abbr").map do |abbr|
      [abbr.text, abbr.attribute("title").text]
    end.to_h
  end

  def definitions
    klass_section[:content].last.children.map do |definition|
      value = definition.text.chomp
      value == "" ? nil : value
    end.compact
  end

  def synonyms
    synonyms_section = find_section("Synonyms")
    return unless synonyms_section

    synonyms_section[:content].last.children.map do |definition|
      value = definition.text.chomp
      value == "" ? nil : value
    end.compact
  end

  def sections
    return @sections if @sections

    last_seen_level = "h1"
    sections = []
    current_section = {}

    clean_body.css(".mw-parser-output").first.children.each do |element|
      next if element.name == "comment"
      next if element.name == "table"
      next if element.text.strip == ""
      next if element.name == "div" && element.attributes["id"]&.value == "toc"

      next if element.name == "h2"

      if element.name =~ /^h/
        # we create a new section
        # "h1" < "h2" => true
        sections << current_section
        current_section = {}
        current_section[:title] = element.css("span.mw-headline").text
      else
        current_section[:content] ||= []
        current_section[:content] << element
      end
    end

    sections << current_section

    sections.delete_at(0)
    @section = sections
  end

  def topics
    page_body
      .css("#mw-normal-catlinks ul")
      .first
      .children
      .select { |element| element.text =~ /^ine-pro:/ }
      .map(&:text)
  end

  def find_section(title)
    sections.find do |section|
      section[:title] == title
    end
  end

  def klass_section
    @klass_section ||= sections.find do |section|
      list_of_classes.include? section[:title]
    end
  end

  def list_of_classes
    @list_of_classes ||= %w(
      Adjective
      Adverb
      Conjunction
      Determiner
      Interjection
      Morpheme
      Numeral
      Prefix
      Infix
      Suffix
      Particle
      Pronoun
      Noun
      Verb
      Root
    )
  end

  def clean_body
    @clean_body ||= page_body.css("#mw-content-text")
  end

  def page_body
    @page_body ||= Nokogiri::HTML(dirty_response_body)
  end

  def dirty_response_body
    @dirty_response_body = HTTParty.get(url).body
  end
end
