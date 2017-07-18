module MiniFlow
  module Layers

    describe Sigmoid do
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
          s= Sigmoid.new([input])
          # set_value_to_input
          input.value= Matrix[
            [-9.0, 4.0],
            [-9.0, 4.0]
          ]

          output= s.forward

          mtx= Matrix[
            [0.00012339457598623172, 0.9820137900379085],
            [0.00012339457598623172, 0.9820137900379085]]
          expect(output).to eq([mtx])
        end

      end
    end

  end
end
