require "byebug"
module ListDefinitionsFilter
  def list_definitions(array)
    values = array.map do |elem|
      definitions = elem.data["definitions"].flatten
      defs = definitions.map do |definition|
        definition
          .gsub("\n", " ")
          .gsub(/ Synonym.*/, "")
          .gsub(/ Antonym.*/, "")
          .strip
      end
    end.flatten
  end
end
Liquid::Template.register_filter(ListDefinitionsFilter)
