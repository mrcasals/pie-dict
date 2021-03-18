require "json"
require "byebug"

class Lemma
  def self.from_json_file(path)
    str = File.read(path)
    hash = JSON.parse(str)
    symbolized_hash = hash.transform_keys {|k| k.to_sym rescue key}
    new(symbolized_hash)
  end

  def initialize(hash)
    @lemma = hash[:lemma]
    @etymology = hash[:etymology] || []
    @klass = hash[:klass]
    @markers = hash[:markers] || []
    @definitions = hash[:definitions] || []
    @synonyms = hash[:synonyms] || []
    @topics = hash[:topics] || []
  end

  attr_reader :lemma, :etymology, :klass, :markers, :definitions, :synonyms, :topics

  def lemma_to_sort
    @lemma_to_sort ||= lemma
      .gsub("*", "")
      .gsub("(", "")
      .gsub(")", "")
      .gsub(/^-/, "")
      .gsub("á", "a")
      .gsub("ā́", "a")
      .gsub("é", "e")
      .gsub("ē", "e")
      .gsub("ḗ", "e")
      .gsub("ǵ", "g'")
      .gsub("í", "i")
      .gsub("ḱ", "k'")
      .gsub("n̥", "n")
      .gsub("ó", "o")
      .gsub("ō", "o")
      .gsub("r̥", "r")
      .gsub("ú", "u")
      .downcase
  end

  def lemma_for_filename
    @lemma_for_filename ||= lemma
      .gsub("*", "")
      .gsub("₁", "1")
      .gsub("₂", "2")
      .gsub("₃", "3")
      .gsub("₄", "4")
  end
end
