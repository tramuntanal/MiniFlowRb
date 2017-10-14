require 'test_helper'

module MiniFlow
  module Model
    describe Base do
      before(:each) do
        some_random_number= 1234
        n_features= n_hidden= n_values= some_random_number
        @model= Base.new([n_values, n_features])
        @model.dense(n_hidden)
      end
      
      describe "Topological sort of the model" do
        it "should produce a sorted graph of model's nodes" do
          x, y= @model.layers[-2], @model.layers[-1]
          feed_dict= {
            x => Matrix[[1,2], [3,4]],
            y => Matrix[[1,2]]
          }
          @model.topological_sort(feed_dict)
          expect(@model.graph).not_to be_nil
        end
      end

      describe "For Stochastic Gradient Descent to be computed," do
        it "should keep track of the trainable nodes in the form of a list" do
          expect(@model.trainables).to be_kind_of(Array)
          expect(@model.trainables.size).to eq(2)
        end
      end

    end
  end
end
