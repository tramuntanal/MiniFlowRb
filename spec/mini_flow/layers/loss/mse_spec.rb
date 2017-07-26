module MiniFlow
  module Layers
    module Loss

      describe Mse do
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
            # configure newron
            mse= Mse.new(y, a)

            output= mse.forward

            expect(output).to be_within(1e-10).of(23.4166666667)
          end

        end
      end

    end
  end
end
