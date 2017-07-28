# We know that each node might receive input from multiple other nodes.
# We also know that each node creates a single output, which will likely be passed to other nodes.
# Let's add two lists: one to store references to the inbound nodes, and the other to store references to the outbound nodes.

module MiniFlow
  class Node
    attr_reader :following_nodes
    attr_accessor :value
    attr_reader :gradients

    def initialize(previous_nodes=[])
      # Node(s) from which this Node receives values
      @previous_nodes= previous_nodes
      # Node(s) to which this Node passes values
      @following_nodes= []
      # For each inbound Node here, add this Node as an outbound Node to _that_ Node.
      @previous_nodes.each do |node|
        node.following_nodes << self
      end
      #Each node will eventually calculate a value that represents its output.
      #Let's initialize the value to None to indicate that it exists but hasn't been set yet.
      @value= nil
      # Keys are the inputs to this node and their values are the partial
      # derivatives of this node with respect to that input.
      @gradients = {}
    end

    # Forward propagation.
    # Compute the output value based on `inbound_nodes` and
    # store the result in @value attribute.
    def forward
      raise NotImplementedError
    end

  end
end
