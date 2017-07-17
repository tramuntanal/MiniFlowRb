# 
module MiniFlow
  module Layers
    class Linear < Node
      def initialize(inputs, weights, bias)
        super(inputs)
        # NOTE: The weights and bias properties here are not
        # numbers, but rather references to other neurons.
        # The weight and bias values are stored within the
        # respective neurons.
        @weights= weights
        @bias= bias
      end

      def forward
        @value= @bias.value

        @previous_nodes.each_with_index {|n, idx|
          @value+= n.value * @weights[idx].value
        }
      end
    end
  end
end
