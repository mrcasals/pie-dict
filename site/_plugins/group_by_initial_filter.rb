module GroupByInitialFilter
  def group_by_initial(array)
    array.group_by do |elem|
      initial = if elem.is_a?(String)
                  elem[0]
                else
                  elem.data["lemma_to_sort"][0]
                end
      initial.upcase
    end
  end
end
Liquid::Template.register_filter(GroupByInitialFilter)

