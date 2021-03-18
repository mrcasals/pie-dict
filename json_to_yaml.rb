require_relative "lib/scraper"

require "json"

Dir["data/*"].each do |json_file_name|
  lemma = Lemma.from_json_file(json_file_name)

  File.open("site/_pie_lemmas/#{lemma.lemma_for_filename}.md", "w") do |f|
    f.puts "---"
    f.puts "title: \"#{lemma.lemma}\""
    f.puts "permalink: \"/pie/#{lemma.klass.downcase}/#{lemma.lemma_for_filename}\""
    f.puts "lemma_to_sort: \"#{lemma.lemma_to_sort}\""
    f.puts "klass: #{lemma.klass.downcase}"
    f.puts "etymology: #{lemma.etymology}"
    f.puts "markers: #{lemma.markers.to_a}"
    f.puts "synonyms: #{lemma.synonyms}"
    f.puts "definitions: #{lemma.definitions}"
    f.puts "topics: #{lemma.topics}"
    f.puts "---"
  end
end
