module MiniFlow
  module Layers

    describe Linear do
      describe "on forward" do

        it %Q[should return 12.7 when feed_dict = {
	x: 6,
	y: 14,
	z: 3,
	weight_x: 0.5,
	weight_y: 0.25,
	weight_z: 1.4,
	bias: 2
}
        ] do
          # construct graph and
          # declare feeded inputs
          x, y, z= Input.new(), Input.new, Input.new()
          inputs= [x, y, z]
          inputs.zip([6, 14, 3]).each {|n, v| n.value= v}

          weight_x, weight_y, weight_z= Input.new(), Input.new(), Input.new()
          weights= [weight_x, weight_y, weight_z]
          weights.zip([0.5, 0.25, 1.4]).each {|n, v| n.value= v}

          bias= Input.new()
          bias.value= 2

          f= Linear.new(inputs, weights, bias)

          f.forward
          expect(f.value).to equal(12.7)
        end

      end
    end

  end
end
