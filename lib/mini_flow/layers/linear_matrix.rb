#
module MiniFlow
  module Layers
    class LinearMatrix < Node
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
        x= @previous_nodes.first.value
        w= @weights.value
        b= @bias.value
        @value= (x * w) + b
      end
    end
  end
end
