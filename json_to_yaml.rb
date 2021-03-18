require_relative "lib/scraper"

require "json"

Dir["data/*waylos*"].each do |json_file_name|
  lemma = Lemma.from_json_file(json_file_name)

  puts "---"
  puts "title: #{lemma.lemma}"
  puts "klass: #{lemma.klass.downcase}"
  puts "etymology:"
  lemma.etymology.each do |element|
    puts "- #{element}"
  end
  puts "markers:"
  lemma.markers.each do |element|
    puts "- #{element}"
  end
  puts "synonyms:"
  lemma.synonyms.each do |element|
    puts "- #{element}"
  end
  puts "definitions:"
  lemma.definitions.each do |element|
    puts "- #{element}"
  end
  puts "topics:"
  lemma.topics.each do |element|
    puts "- #{element}"
  end
  puts "---"
end
