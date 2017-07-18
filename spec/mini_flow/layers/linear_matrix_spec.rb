require 'matrix'
module MiniFlow
  module Layers

    describe LinearMatrix do
      describe "on forward" do
        before(:each) do
          @x, @y= Input.new, Input.new
          @mul= Mul.new(@x, @y)
        end

        it %Q[should return [[-9., 4.],[-9., 4.]] when inputs, weights and bias are:
          x = np.array([[-1., -2.], [-1, -2]])
          w = np.array([[2., -3], [2., -3]])
          b = np.array([-3., -5])
        ] do
          # construct graph
          inputs, weights, bias= Input.new(), Input.new, Input.new()
          f= LinearMatrix.new([inputs], weights, bias)
          # declare feeded inputs
          x= Matrix[
            [-1.0, -2.0],
            [-1, -2]]
          w= Matrix[
            [2.0, -3],
            [2.0, -3]]
          b_vect= [-3.0, -5]
          b= Matrix.rows([b_vect,b_vect], copy: false)
          feed_dict = {inputs => x, weights => w, bias => b}

          graph= MiniFlow.topological_sort(feed_dict)
          output = MiniFlow.forward_pass(f, graph)
          expect(output).to eq(Matrix[[-9.0, 4],[-9.0, 4]])
        end

      end
    end

  end
end
