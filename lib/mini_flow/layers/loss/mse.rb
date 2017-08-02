require 'matrix'
module MiniFlow
  module Layers
    module Loss
      #
      # Accuracy measured as mean squared error:
      #
      # 1/m x (sum of the squared differences between a and y(x))
      #
      # _m_ is the total number of training examples,
      # _a_ is the approximation of _y(x)_ by the network,
      # both _a_ and _y(x)_ are vectors of the same length.
      # _y_ is the ground truth result or label.
      #
      class Mse < Node
        def initialize(y, a)
          @y, @a= y, a
          super([@y, @a])
        end

        # Calculates the mean squared error.
        def forward
          sum= 0
          raise TypeError.new("Incompatible types y:#{@y.value.class} vs a:#{@a.value.class}") unless @y.value.kind_of?(@a.value.class)
          case @y.value
          when Matrix
            @diffs= @y.value - @a.value
            @sum= @diffs ** 2
          when Array, Vector
            @diffs= []
            @y.value.zip(@a.value).each do |y_val, a_val|
              diff= y_val - a_val
              sum+= diff ** 2
              @diffs << diff
            end
            @sum= sum
            @diffs= Vector.elements(@diffs)
          end
          @m= @y.value.size.to_f
          @value= (1.0/@m) * @sum
        end

        def backward
          @gradients[@y]= (2 / @m) * @diffs
          @gradients[@a]= (-2 / @m) * @diffs
        end
      end

    end
  end
end
