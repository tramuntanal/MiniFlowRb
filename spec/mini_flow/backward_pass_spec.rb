require_relative '../test_helper'

module MiniFlow
  describe "MiniFlow.backward_pass with Loss::Mse" do

    before(:all) do
      # prepare_input
      y, a= Layers::Input.new(), Layers::Input.new()
      # configure newron
      @mse= Layers::Loss::Mse.new(y, a)

      feed_dict= {y => [1, 2, 3], a => [4.5, 5, 10]}
      @sorted_neurons= MiniFlow.topological_sort(feed_dict)
      MiniFlow.forward_pass(@mse, @sorted_neurons)
      MiniFlow.backward_pass(@sorted_neurons)
    end

    it "should set the gradient of the last node" do
      expect(@mse.gradients.size).to eql(2)
    end
    it "should compute the gradient in all neurons" do
      @sorted_neurons.each {|n|
        next if n.kind_of?(Layers::Input)
        expect(n.gradients.any?).to be true
        n.gradients.each_pair {|node, grad|
          next if node.kind_of?(Layers::Input)
          expect(grad).to exist
        }
      }
    end

  end
end

