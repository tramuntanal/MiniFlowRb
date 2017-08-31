# An Input node has no inbound nodes.
#
# Unlike the other subclasses of Node, the Input subclass does not actually calculate anything.
# The Input subclass just holds a value, such as a data feature or a model parameter (weight/bias).
# You can set value either explicitly or with the forward() method.
# This value is then fed through the rest of the neural network.
#
module MiniFlow
  module Layers
    class Input < Node
      # NOTE: Input node is the only node where the value
      # may be passed as an argument to forward().
      #
      # All other node implementations should get the value
      # of the previous node from @previous_nodes
      #
      # Example:
      # val0 = @previous_nodes[0].value
      def forward(value=nil)
        @value= value if value
      end

      # An Input layer has no inputs so the gradient (derivative) is zero.
      #
      # Anyway, weights and bias may be inputs, so we need to sum
      # the gradient from output gradients.
      #
      def backward
        @gradients[self]= case @value
        when Vector, Array
          Vector.zero(@value.size)
        when Matrix
          Matrix.zero(@value.row_count, @value.column_size)
        else
          0.0
        end
        @following_nodes.each {|n| @gradients[self]+= n.gradients[self]}
      end

    end
  end
end
