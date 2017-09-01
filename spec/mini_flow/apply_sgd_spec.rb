require_relative '../test_helper'

module MiniFlow
  describe "When applying MiniFlow.apply_sgd" do
    W_VALUE= Vector[-2.2, 3.4]
    W_GRADIENT= Vector[-1, -1]
    B_VALUE= -3.9
    B_GRADIENT= -1
    LEARNING_RATE= 1e-2

    before(:all) do
      having_weights_with_value(W_VALUE)
      and_having_weights_with_gradient(W_GRADIENT)
      having_bias_with_value(B_VALUE)
      and_having_bias_with_gradient(B_GRADIENT)

      having_learning_rate(LEARNING_RATE)

      and_applying_the_sgd
    end

    it %Q"should change the value of `weights` by applying its partial gradient at
      the given learning rate" do
      expected= W_VALUE - (W_GRADIENT * LEARNING_RATE)
      expect(@w.value).to eq(expected)
    end
    it %Q"should change the value of `bias` by applying its partial gradient at
      the given learning rate" do
      expected= B_VALUE - (B_GRADIENT * LEARNING_RATE)
      expect(@b.value).to eq(expected)
    end

    #-----------------------------------------------
    private
    #-----------------------------------------------

    def having_weights_with_value(val)
      @w= Layers::Input.new
      @w.value= val
    end
    def and_having_weights_with_gradient(grad)
      @w.gradients[@w]= grad
    end
    def having_bias_with_value(val)
      @b= Layers::Input.new
      @b.value= val
    end
    def and_having_bias_with_gradient(grad)
      @b.gradients[@b]= grad
    end
    def having_learning_rate(lr)
      @learning_rate= lr
    end
    def and_applying_the_sgd
      MiniFlow.apply_sgd([@w, @b], @learning_rate)
    end
  end
end

