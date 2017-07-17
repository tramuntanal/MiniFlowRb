require_relative '../test_helper'

module MiniFlow
  describe "MiniFlow.forward_pass with add" do

    before(:all) do
      x, y= Layers::Input.new(), Layers::Input.new()
      output_neuron= Layers::Add.new(x, y)
      feed_dict = {x => 2123, y => 877}
      sorted_neurons= MiniFlow.topological_sort(feed_dict)
      @output = MiniFlow.forward_pass(output_neuron, sorted_neurons)
    end

    it "should return a result" do
      expect(@output).not_to be_nil
    end
    it "should return the addition of the input values" do
      expect(@output).to equal(3000)
    end

  end
end

