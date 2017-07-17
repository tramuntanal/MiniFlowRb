module MiniFlow

  # Performs a forward pass through a list of sorted neurons.
  #   Arguments:
  # @param `output_neuron`: A neuron in the graph, should be the output neuron
  #   (have no outgoing edges).
  # @param `sorted_neurons`: a topologically sorted list of neurons.
  # 
  # @returns the output neuron's value
  def self.forward_pass(output_neuron, sorted_neurons)
    sorted_neurons.each { |sn| sn.forward }
    output_neuron.value
  end

end