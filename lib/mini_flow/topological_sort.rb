module MiniFlow

  # Sort generic nodes in topological order using Kahn's Algorithm.
  # @param `feed_dict`: A dictionary where the key is a `Input` node and the
  #   value is the respective value feed to that node.
  # @returns a list of sorted nodes.
  def self.topological_sort(feed_dict)
    input_nodes = feed_dict.keys.clone

    # build the graph
    graph= {}
    nodes= input_nodes.clone
    while nodes.any?
      # remove first node
      n= nodes.shift

      graph[n]= {in: [], out: []} unless graph.include?(n)
      n.following_nodes.each { |m|
        graph[m]= {in: [], out: []} unless graph.include?(m)
        graph[n][:out] << m
        graph[m][:in] <<n
        nodes << m
      }
    end

    # sort the graph
    list= []
    input_nodes= input_nodes.clone
    while input_nodes.any?
      n= input_nodes.pop

      n.value= feed_dict[n] if n.kind_of?(Layers::Input)

      list << n
      n.following_nodes.each { |m|
        graph[n][:out].delete(m)
        graph[m][:in].delete(n)
        # if no other incoming edges add to input_nodes
        input_nodes << m if graph[m][:in].empty?
      }
    end
    list
  end

end