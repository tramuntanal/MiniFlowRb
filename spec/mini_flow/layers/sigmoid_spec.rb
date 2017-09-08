module MiniFlow
  module Layers
    describe Sigmoid do

      context "on forward" do
        describe %Q{when input is:
            [ [-9., 4.],
              [-9., 4.] ]
        } do

          it %Q{should return
            [ [1.23394576e-04,   9.82013790e-01],
              [1.23394576e-04,   9.82013790e-01] ]
          } do
            # prepare_input_and_sigmoid
            input= Input.new()
            s= Sigmoid.new(input)
            # set_value_to_input
            input.value= Matrix[
              [-9.0, 4.0],
              [-9.0, 4.0]
            ]

            output= s.forward

            mtx= Matrix[
              [0.00012339457598623172, 0.9820137900379085],
              [0.00012339457598623172, 0.9820137900379085]]
            expect(output).to eq(mtx)
          end
        end
      end

      context "on backward," do
        describe %Q{after forwarding:
            [ [-9., 4.],
              [-9., 4.] ]
            and having an outbound layer that computed the sigmoid's partial gradient as Matrix[
              [-0.4999383027120069, -0.5089931049810458],
              [-1.9999383027120068, -2.008993104981046]]
        } do

          it %Q{should compute the following gradients
            [ [-0.9907867794178487, -0.017822698266569445],
              [-3.9368347620551654, -0.07081747510869837] ]
          } do
            # prepare_input_and_sigmoid
            input= Input.new()
            s= Sigmoid.new(input)
            # set_value_to_input
            input_value= Matrix[
              [-9.0, 4.0],
              [-9.0, 4.0]
            ]
            # prepare_following_node
            y= Input.new()
            mse= Loss::Mse.new(y, s)

            # pass forward and backward
            feed_dict = {input => input_value, y => Matrix[[1, 2],[4,5]]}
            MiniFlow.fit(mse, feed_dict)

            expect(s.gradients.any?).to be true
            mtx= Matrix[
              [-0.9996765057192436, -0.01798261048263196],
              [-3.9457244883565608, -0.07097738732476089]]
            input_grad= s.gradients[input]
            expect(input_grad).to eql(mtx)
          end
        end

      end
    end
  end
end