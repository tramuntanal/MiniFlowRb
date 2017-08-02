module MiniFlow
  module Layers

    describe Input do
      context "on backwards" do

        describe "when there are no outbound nodes, gradient (derivative)" do
          before(:all) do
            @input= Input.new()
            @input.value= Matrix[
              [1, 2.2, 33.33],
              [400, 55.43, 2.1]
            ]
            @input.backward
          end
          it "should have computed only the gradient for itself" do
            expect(@input.gradients.size).to be 1
            expect(@input.gradients.keys.first).to equal @input
          end
          it "should be zero" do
            expect(@input.gradients.values.first).to eql Matrix.zero(2,3)
          end
        end
        describe %Q"when the input is outbound to 2 other nodes with gradient
          1.2 and 2.2, its gradient" do
          before(:all) do
            @input= Input.new()
            @input.value= Vector[400, 55.43, 2.1]
            out1, out2= Input.new, Input.new
            out1.gradients[@input]= Vector[1.5, 0, 2]
            out2.gradients[@input]= Vector[2.6, 0, 1]
            @input.following_nodes << out1
            @input.following_nodes << out2
            # we're not backpropagating the chain rule to compute the gradient on the
            # 3 nodes. We've already set the gradient of the outbound nodes and
            # ask @input to compute its gradient
            @input.backward
          end
          it "should have computed only the gradient for itself" do
            expect(@input.gradients.size).to be 1
            expect(@input.gradients.keys.first).to be @input
          end
          it "should be equal to the sum of the gradients of the outbound nodes" do
            expect(@input.gradients.values.first).to eql Vector[4.1,0.0,3.0]
          end
        end

      end
    end

  end
end
