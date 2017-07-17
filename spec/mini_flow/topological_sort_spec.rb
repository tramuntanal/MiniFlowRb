require_relative '../test_helper'

module MiniFlow
  describe "MiniFlow.topological_sort" do

    before(:all) do
      # define the graph
      x, y= Layers::Input.new(), Layers::Input.new()
      Layers::Add.new(x, y)
      # feed data and sort neurons
      feed_dict = {x => 10, y => 5}
      @sorted_neurons= MiniFlow.topological_sort(feed_dict)
    end

    it "should return all neurons" do
      expect(@sorted_neurons.size).to eq(3)
    end
    it "should return Add hidden neuron" do
      hidden= @sorted_neurons.pop
      expect(hidden.kind_of?(Layers::Add)).to be true
    end
    it "should feed the values into Input neurons" do
      expect(@sorted_neurons.first.value).to eq(5)
      expect(@sorted_neurons.last.value).to eq(10)
    end

  end
end

