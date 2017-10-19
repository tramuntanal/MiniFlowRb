require_relative 'matrix_ext'
require_relative 'mini_flow/layers/node'
require_relative 'mini_flow/layers/input'
require_relative 'mini_flow/layers/add'
require_relative 'mini_flow/layers/mul'
require_relative 'mini_flow/layers/linear'
require_relative 'mini_flow/layers/linear_matrix'
require_relative 'mini_flow/layers/sigmoid'

require_relative 'mini_flow/layers/loss/mse'

require_relative 'mini_flow/topological_sort'
require_relative 'mini_flow/forward_pass'
require_relative 'mini_flow/backward_pass'
require_relative 'mini_flow/sgd'
require_relative 'mini_flow/resampler'


require_relative 'mini_flow/model/base'

require_relative 'mini_flow/examples/examples'

module MiniFlow
  def self.sort_and_forward(output_node, feed_dict)
    graph= MiniFlow.topological_sort(feed_dict)
    MiniFlow.forward_pass(output_node, graph)
    graph
  end

  def self.forward_and_backward(graph)
    MiniFlow.forward_pass(graph.last, graph)
    MiniFlow.backward_pass(graph)
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