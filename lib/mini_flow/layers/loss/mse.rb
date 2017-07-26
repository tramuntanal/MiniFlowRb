module MiniFlow
  module Layers
    module Loss
      #
      # Accuracy measured as mean squared error.
      # 1/m (sum of the squared differences between a and y(x))
      # _m_ is the total number of training examples, _a_ is the approximation
      # of _y(x)_ by the network, both _a_ and _y(x)_ are vectors of the same length.
      #
      class Mse < Node
        def initialize(y, a)
          super([y, a])
        end

        # Calculates the mean squared error.
        def forward
          y= @previous_nodes.first.value
          a= @previous_nodes.last.value

          sum= 0
          y.zip(a).each do |y_val, a_val|
            sum+= (y_val - a_val) ** 2
          end
          @value= (1.0/y.size.to_f) * sum
        end

      end

    end
  end
end
