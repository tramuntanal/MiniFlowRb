# Stochastic Gradient Descent
module MiniFlow

  # Makes the neurons/nodes/layers learn by moving its value in the direction
  # to converge with the global minimum.
  # Changes each trainable's value by subtracting the learning rate
  # multiplied by the partial of the cost with respect to the
  # trainable.
  #
  # @param inputs: the trainables.
  # @param learning_rate: the rate at wich the value is updated in the direction
  #   of the partial of the cost with respect to the input.
  #
  def self.apply_sgd(inputs, learning_rate)
    inputs.each {|input|
      input.value-= learning_rate * input.gradients[input]
    }
  end

end