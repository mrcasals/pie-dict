module GroupByInitialFilter
  def group_by_initial(array)
    array.group_by { |elem| elem.data["lemma_to_sort"][0].upcase }
  end
end
Liquid::Template.register_filter(GroupByInitialFilter)

