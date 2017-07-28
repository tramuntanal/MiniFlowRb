#
module MiniFlow
  module Layers

    # Let's take a look at an example of n inputs.
    # Consider an 28px by 28px greyscale image, as is in the case of images in the MNIST dataset.
    # We can reshape the image such that it's a 1 by 784 matrix, n = 784.
    # Each pixel is an input/feature. Here's an animated example emphasizing a pixel is a feature.
    #
    # In practice, it's common to feed in multiple data examples in each forward pass rather than just 1.
    # The reasoning for this is the examples can be processed in parallel,
    # resulting in big performance gains.
    # The number of examples is called the batch size.
    # Common numbers for the batch size are 32, 64, 128, 256, 512.
    # Generally, it's the most we can comfortably fit in memory.
    #
    # What does this mean for X, W and b?
    #
    # X becomes a m by n matrix and W and b remain the same. The result of the matrix multiplication is now m by k, so the addition of b is broadcast over each row.
    #
    # In the context of MNIST each row of X is an image reshaped from 28 by 28 to 1 by 784.
    #
    #
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
