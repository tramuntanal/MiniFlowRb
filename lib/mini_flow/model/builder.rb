module MiniFlow
  module Builder

    #
    # @params units: Positive integer, dimensionality of the output space.
    #
    def dense(units)
      input_shape= @input_shapes.last
      w_mtx_= Matrix.build(input_shape.last, units) { rand }
      b_vect_= Matrix.zero(input_shape.first, units)
      @input_shapes << [input_shape.first, units]
      w_mtx_input, b_vect_input= Layers::Input.new(), Layers::Input.new()
      @feed_dict[w_mtx_input]= w_mtx_
      @feed_dict[b_vect_input]= b_vect_

      @trainables << w_mtx_input << b_vect_input
      @output_layer= MiniFlow::Layers::LinearMatrix.new(@layers.last, w_mtx_input, b_vect_input)
      @layers << @output_layer
      @output_layer
    end

    def activation(type)
      @output_layer= case type
      when :sigmoid
        MiniFlow::Layers::Sigmoid.new(@layers.last)
      else
        raise ArgumentError.new("Unsupported activation type")
      end
      @layers << @output_layer
      @output_layer
    end

    def loss(type)
      loss_layer= case type
      when :mse
        MiniFlow::Layers::Loss::Mse.new(@y_input, @layers.last)
      else
        raise ArgumentError.new("Unsupported loss type")
      end
      @layers << loss_layer
      loss_layer
    end

  end
end
