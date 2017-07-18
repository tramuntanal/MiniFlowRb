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
    end
  end
end