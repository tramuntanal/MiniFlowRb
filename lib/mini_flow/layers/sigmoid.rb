module MiniFlow
  module Layers
    #
    # The sigmoid function is used as an activation function.
    # sigmoid(x)= 1/(1+e^-x)
    # It has S shape.
    #
    # Conceptually, the sigmoid function makes decisions. When given weighted
    # features from some data, it indicates whether or not the features
    # contribute to a classification. In that way, a sigmoid activation works
    # well following a linear transformation.
    #
    # As it stands right now with random weights and bias, the sigmoid node's output is also random.
    # The process of learning through backpropagation and gradient descent
    # modifies the weights and bias such that activation of the sigmoid node
    # begins to match expected outputs.
    #
    class Sigmoid < Node
      # Sigmoid only accepts input from one node
      def initialize(input)
        super([input])
      end

      def forward
        @value= sigmoid(@previous_nodes.first.value)
      end

      def backward
        # Initialize the gradients to 0.
        @previous_nodes.collect {|n|
          rows, cols= n.value.row_count, n.value.column_size
          @gradients[n]= Matrix.zero(rows, cols)
        }

        # Cycle through the outputs and get partial gradients.
        # The gradient will change depending on each output,
        # so the gradients are summed over all outputs.
        @following_nodes.each {|n|
          # Get the partial of the cost with respect to this layer.
          grad_cost= n.gradients[self]
          # Set the gradients property to the gradients
          # with respect to each input.
          # Set the partial of the loss with respect to this layer's inputs.
          input_value= @previous_nodes[0].value
          s_mtx= sigmoid(input_value)
          ones_mtx= Matrix.build(s_mtx.row_count, s_mtx.column_size) {1}
          @gradients[@previous_nodes[0]]+= grad_cost*(s_mtx.transpose*(ones_mtx-s_mtx))
        }
      end

      #---------------------------------------
      private
      #---------------------------------------

      # Implementation of the sigmoid function.
      def sigmoid(x)
        x.collect {|elem| 1.0 / ( 1 + Math.exp(-1*elem))}
      end
    end

  end
end
