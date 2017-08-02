module MiniFlow

  # Starts a backward pass from the last node of the sorted list of neurons so to apply the derivative chain rule.
  # Thus, nodes are backwarded from the last to the first.
  #
  #   Arguments:
  # @param `sorted_nodes`: Sorted nodes/neurons/layers in the graph.
  #
  # @returns the output neuron's value
  def self.backward_pass(sorted_nodes)
    sorted_nodes.reverse.each {|node|
      node.backward
    }
  end

end