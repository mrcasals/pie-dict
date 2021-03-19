require "byebug"
module ListDefinitionsFilter
  def list_definitions(array)
    array.flat_map do |elem|
      elem.data["definitions"]
    end
  end
end
Liquid::Template.register_filter(ListDefinitionsFilter)
