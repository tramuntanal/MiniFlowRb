require './test_helper'

module MiniFlow
  class TopologicalSortTest < Test::Unit::TestCase
    def test_basic_usage
      x, y= Layers::Input.new(), Layers::Input.new()
      f= Layers::Add.new(x, y)
      feed_dict = {x => 10, y => 5}
      sorted_neurons = topological_sort(feed_dict)
      assert_equals(3, sorted_neurons.size)
      last_neuron= sorted_neurons.pop
      assert_true(last_neuron.kind_of?(Layers::Add))
      
    end
  end
end
