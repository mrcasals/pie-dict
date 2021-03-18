require_relative "lib/scraper"

require "json"

Dir["data/*waylos*"].each do |json_file_name|
  lemma = Lemma.from_json_file(json_file_name)

  File.open("site/_pie_lemmas/#{lemma.lemma_to_order}.md", "w") do |f|
    f.puts "---"
    f.puts "title: \"#{lemma.lemma}\""
    f.puts "klass: #{lemma.klass.downcase}"
    f.puts "etymology:"
    lemma.etymology.each do |element|
      f.puts "- #{element}"
    end
    f.puts "markers:"
    lemma.markers.each do |element|
      f.puts "- #{element}"
    end
    f.puts "synonyms:"
    lemma.synonyms.each do |element|
      f.puts "- #{element}"
    end
    f.puts "definitions:"
    lemma.definitions.each do |element|
      f.puts "- #{element}"
    end
    f.puts "topics:"
    lemma.topics.each do |element|
      f.puts "- #{element}"
    end
    f.puts "---"
  end
end
