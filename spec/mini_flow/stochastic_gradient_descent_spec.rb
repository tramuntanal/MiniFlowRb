require_relative '../test_helper'

module MiniFlow
  describe "MiniFlow stochastic gradient descent with Housing Values in Suburbs of Boston" do

    it "must improve loss after each epoch" do
      given_the_boston_model
      after_executing_it
      loss_should_decrease_after_each_epoch
    end

    #--------------------------------------
    private
    #--------------------------------------

    def given_the_boston_model
      @model= MiniFlow::Examples::BostonModel.new
    end
    def after_executing_it
      @epochs= 10
      @model.run(epochs: @epochs)
    end
    def loss_should_decrease_after_each_epoch
      from_second_to_last= (1...@epochs)
      from_second_to_last.each {|idx|
        previous_idx= idx - 1
        num_items= 2
        previous, current= @model.losses[previous_idx, num_items]
        expect(previous).to be > current
        #        "Loss should decrease between %i and %i epochs: %f > %f" %
        #          [previous_idx, idx, previous, current]
        #        )
      }
    end
  end
end
