# 
module MiniFlow
  module Layers
    class Add < Node
      def initialize(*args)
        super(args)
      end

      def forward
        @value= @previous_nodes.collect {|n| n.value}.inject(:+)
      end
    end
  end
end
