require 'matrix'
module MiniFlow
  module Layers

    describe LinearMatrix do
      X= Matrix[
        [-1.0, -2.0],
        [-1.0, -2.0]]
      W= Matrix[ [2.0],[-3.0] ]
      #      B_VECT= Vector[-3.0]
      #      B= Matrix.rows([B_VECT,B_VECT], copy: false)
      B= Vector[-3.0, -3.0]


      context "on forward" do
        it %Q[should return [[1, 1],[1, 1]] when inputs, weights and bias are:
          x = #{X}
          w = #{W}
          b = #{B}
        ] do
          construct_graph
          build_feed_dict

          graph= MiniFlow.topological_sort(@feed_dict)
          output = MiniFlow.forward_pass(@f, graph)

          expect(output).to eq(Matrix[[1.0],[1.0]])
        end
      end
      context "on backwards" do
        before(:each) do
          construct_graph
          build_feed_dict
        end
        describe "whatever the values of the input nodes, when there are no outbound nodes, then the gradients" do
          it "should be zero" do
            forward_and_backward(@f)

            expect(@f.gradients[@input]).to eq(Matrix[[0, 0],[-0.0, 0]])
            expect(@f.gradients[@weights]).to eq(Matrix[[0],[0]])
            expect(@f.gradients[@bias]).to eq(Vector[0.0,0.0])
          end
        end
        describe "Given there is a sigmoid outbound node" do
          it %Q{should calculate the following gradients:} do
            s= Sigmoid.new(@f)
            s.gradients[@f]= Matrix[[1], [2]]

            forward(s)
            @f.backward

            expect(@f.gradients[@input]).to eq(Matrix[[2, -3],[4, -6]])
            expect(@f.gradients[@weights]).to eq(Matrix[[-3],[-6]])
            expect(@f.gradients[@bias]).to eq(Vector[1.0, 2.0])
          end
        end
      end

      #-----------------------------------------------------
      private
      #-----------------------------------------------------

      def construct_graph
        @input, @weights, @bias= Input.new(), Input.new, Input.new()
        @f= LinearMatrix.new(@input, @weights, @bias)
      end
      def build_feed_dict
        @feed_dict = {@input => X, @weights => W, @bias => B}
      end
      def forward(output_node)
        graph= MiniFlow.topological_sort(@feed_dict)
        MiniFlow.forward_pass(output_node, graph)
        graph
      end
      def forward_and_backward(output_node)
        graph= forward(output_node)
        MiniFlow.backward_pass(graph)
      end

    end
  end
end
