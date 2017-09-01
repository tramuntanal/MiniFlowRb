require 'matrix_ext'
require 'mini_flow/layers/node'
require 'mini_flow/layers/input'
require 'mini_flow/layers/add'
require 'mini_flow/layers/mul'
require 'mini_flow/layers/linear'
require 'mini_flow/layers/linear_matrix'
require 'mini_flow/layers/sigmoid'

require 'mini_flow/layers/loss/mse'

require 'mini_flow/topological_sort'
require 'mini_flow/forward_pass'
require 'mini_flow/backward_pass'

require 'mini_flow/examples/examples'

module MiniFlow
  def self.sort_and_forward(output_node, feed_dict)
    graph= MiniFlow.topological_sort(feed_dict)
    MiniFlow.forward_pass(output_node, graph)
    graph
  end

  # Performs:
  # - a topological sort
  # - a forward pass
  # - a backward pass
  #
  # @return the graph
  def self.fit(output_node, feed_dict)
    graph= MiniFlow.sort_and_forward(output_node, feed_dict)
    MiniFlow.backward_pass(graph)
    graph
  end
end