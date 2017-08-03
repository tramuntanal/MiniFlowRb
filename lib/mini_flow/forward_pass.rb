module MiniFlow

  # Performs a forward pass through a list of sorted nodes.
  #   Arguments:
  # @param `output_node`: A node in the graph, should be the output node
  #   (have no outgoing edges).
  # @param `sorted_nodes`: a topologically sorted list of nodes.
  #
  # @returns the output neuron's value
  def self.forward_pass(output_node, sorted_nodes)
    sorted_nodes.each { |sn| sn.forward }
    output_node.value
  end

end