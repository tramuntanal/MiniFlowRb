module MiniFlow
  module Layers
    module Loss

      describe Mse do

        describe "on forward" do
          describe %Q{when input is:
            y= [1, 2, 3]
            a= [4.5, 5, 10]
          } do

            it %Q{should return 23.4166666667} do
              # prepare_input
              y, a= Input.new(), Input.new()
              # set_value_to_input
              y.value= [1, 2, 3]
              a.value= [4.5, 5, 10]
              # configure neuron
              mse= Mse.new(y, a)

              output= mse.forward

              expect(output).to be_within(1e-10).of(23.4166666667)
            end
          end
        end

        describe "on backward" do
          describe %Q{when
            m= 3
            diff= [-3.5, -3, -7]
            gradients on each input node should be seted and
          } do

            it %Q{should be
              gradient of a= [0.33,0.0,1.33]
              gradient of y= [-0.33,0.0,-1.33]
            } do
              # prepare_input
              y, a= Input.new(), Input.new()
              # set_value_to_input
              y.value= [1, 2, 3]
              a.value= [4.5, 5, 10]
              # configure node
              mse= Mse.new(y, a)

              output= mse.forward
              mse.backward

              y_grad= mse.gradients[y]
              expect(y_grad).to eq(Vector[-2.333333333333333, -2.0, -4.666666666666666])
              a_grad= mse.gradients[a]
              expect(a_grad).to eq(Vector[2.333333333333333, 2.0, 4.666666666666666])
            end
          end
        end


      end
    end
  end
end
