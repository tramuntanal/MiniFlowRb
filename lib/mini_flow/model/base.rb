require_relative 'builder'

module MiniFlow
  module Model
    class Base
      include Builder

      attr_reader :layers
      attr_reader :graph
      attr_reader :trainables

      def initialize(input_shape)
        # The shape of the input for the following layer to be build.
        # Must be set at initialization. Then it is updated after adding a new layer
        @input_shapes= [input_shape]
        @feed_dict= {}
        @layers= []
        @x_mtx_input, @y_input= Layers::Input.new(), Layers::Input.new()
        @layers << @x_mtx_input
        @trainables= []
      end

      def compile(loss: :mse, optimizer: :sgd)
        @cost_node= self.loss(:mse)
        @feed_dict[@x_mtx_input]= nil
        @feed_dict[@y_input]= nil
        topological_sort(@feed_dict)
      end

      #
      # Performs a resample of X and y inputs on each epoch.
      #
      def fit(x_mtx, y, epochs)
        n_values= x_mtx.row_size
        batch_size= (n_values/epochs).to_i
        @losses= []
        resampler= MiniFlow::Resampler.new
        epochs.times {|epoch|
          loss= 0
          # Step 1
          # Randomly sample a batch of examples
          x_mtx_batch, y_batch= resampler.resample_batch(
            [x_mtx, Matrix[y.to_a].transpose],
            iter: epoch,
            batch_size: batch_size)

          x_mtx_batch.to_a.zip(y_batch).each { |x, y|
            # Reset value of X and y Inputs
            @x_mtx_input.value= Matrix.rows [x]
            @y_input.value= Matrix.rows [y]

            # Step 2
            MiniFlow.forward_and_backward(@graph)
          }

          # Step 3
          train
          loss+= @cost_node.value.first
          @losses << loss
          puts("Epoch: #{epoch+1}, Loss:"+" %.3f" % (loss / batch_size))
        }
      end

      def topological_sort(feed_dict)
        @graph= MiniFlow.topological_sort(feed_dict)
      end

      def train
        MiniFlow.apply_sgd(@trainables, 0.0001)
      end

      def predict(features)
        input_shape= @input_shapes.first
        features_mtx= Matrix.build(input_shape.first, input_shape.last) {|r,c|
          features[c]
        }
        @x_mtx_input.value= features_mtx
        output_node= @output_layer
        MiniFlow.forward_pass(output_node, @graph)
        output_node.value
      end

      def print_graph_arch
        @graph.each {|node| puts node.to_s }
      end

      #-----------------------------------------------------------
      private
      #-----------------------------------------------------------

      #
      # Randomly selects the same indices from each Enumerable.
      # The number of seleced samples is determined by +n_samples+.
      #
      def resample(mtx, epoch, batch_size)
        random_indices= (0...batch_size).to_a.sample(batch_size)
        n_features= mtx.column_size
        first_idx= epoch*batch_size
        last_idx= first_idx+batch_size
        slice= Matrix.rows mtx.to_a[first_idx..last_idx]
        new_mtx= Matrix.build(batch_size, n_features) {|r,c|
          random_row_idx= random_indices[r]
          new= slice[random_row_idx, c]
          new
        }

        new_mtx
      end

    end
  end
end