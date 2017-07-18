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
      def initialize(inputs)
        super(inputs)
      end

      def forward
        @value= []
        @previous_nodes.each do |n|
          @value << sigmoid(n.value)
        end
        @value
      end
      
      private
      # Implementation of the sigmoid function.
      def sigmoid(x)
        x.collect {|elem| 1.0 / ( 1 + Math.exp(-1*elem))}
      end
    end

  end
end
