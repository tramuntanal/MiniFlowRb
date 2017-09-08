
module MiniFlow
  module Examples
    # Example Boston Model Architecture:
    # Input: 506x13
    # Linear: X[506,13], W[506,10], b[506]
    # Sigmoid: [506, 1]
    # Linear: X[506, 1], W[10,1], b[1]
    # Cost in: y[506, 1], a[506, 1]
    # Cost result: [1, 1]
    #
    class BostonModel

      attr_reader :losses

      def initialize
        @dataset= MiniFlow::Examples.load_boston
      end

      def run(epochs: 10, batch_size: 506)
        df= @dataset
        x_df= df[:data]

        x_mtx= normalize(x_df)
        y_vect= df[:target].to_matrix

        n_features= x_df.ncols
        n_values= x_df.nrows
        n_hidden= 10
        w1_mtx_= Matrix.build(n_features, n_hidden) { rand }
        b1_vect_= Matrix.zero(n_values, n_hidden)
        w2_mtx_= Matrix.build(n_hidden, 1) { rand }
        b2_vect_= Matrix.zero(n_values, 1)

        ## Neural network
        x_mtx_input, y_vect_input= Layers::Input.new(), Layers::Input.new()
        w1_mtx_input, b1_vect_input= Layers::Input.new(), Layers::Input.new()
        w2_mtx_input, b2_vect_input= Layers::Input.new(), Layers::Input.new()

        l1= Layers::LinearMatrix.new(x_mtx_input, w1_mtx_input, b1_vect_input)
        s1= Layers::Sigmoid.new(l1)
        l2= Layers::LinearMatrix.new(s1, w2_mtx_input, b2_vect_input)
        cost= Layers::Loss::Mse.new(y_vect_input, l2)

        feed_dict = {
          x_mtx_input => x_mtx,
          y_vect_input => y_vect,
          w1_mtx_input => w1_mtx_,
          b1_vect_input => b1_vect_,
          w2_mtx_input => w2_mtx_,
          b2_vect_input => b2_vect_
        }

        steps_per_epoch= (n_values / batch_size).to_i

        graph= MiniFlow.topological_sort(feed_dict)
        trainables= [w1_mtx_input, b1_vect_input, w2_mtx_input, b2_vect_input]

        puts("Total number of examples= #{n_values}")

        ## Step 4
        puts "Going to iterate #{epochs} epochs with #{steps_per_epoch} steps_per_epoch at a batch size of #{batch_size}."
        @losses= []
        epochs.times {|idx|
          loss= 0
          steps_per_epoch.times {|j|
            # Step 1
            # Randomly sample a batch of examples
            x_mtx_batch, y_batch= resample(x_mtx, y_vect, n_samples: batch_size)

            # Reset value of X and y Inputs
            x_mtx_input.value= x_mtx_batch
            y_vect_input.value= y_batch

            # Step 2
            MiniFlow.forward_and_backward(graph)

            # Step 3
            MiniFlow.apply_sgd(trainables)
            puts "cost.value: #{cost.value.dimensions}"
            loss+= cost.value.first
          }
          @losses << loss
          puts("Epoch: #{idx+1}, Loss:"+" %.3f" % (loss / steps_per_epoch))
        }
      end

      #----------------------------------------------------
      private
      #----------------------------------------------------
      def normalize(df)
        means_vect= df.mean
        row= means_vect.collect {|e| [e]}
        means_df= Daru::DataFrame.new(row, order: df.row[0].index)
        ary= means_vect.to_a
        (df.size-1).times { means_df.add_row(ary) }
        std_vect= df.std
        row= std_vect.collect {|e| [e]}
        std_df= Daru::DataFrame.new(row, order: df.row[0].index)
        ary= std_vect.to_a
        (df.size-1).times { std_df.add_row(ary) }
        mtx= ((df - means_df) / std_df).to_matrix
        mtx
      end

      #
      # Randomly selects the same indices from each Enumerable.
      # The number of seleced samples is determined by +n_samples+.
      #
      def resample(x_mtx, y_vect, n_samples: 1)
        x_mtx
        random_indices= (0...x_mtx.row_count).to_a.sample(n_samples)
        new_x_mtx= Matrix.build(n_samples, x_mtx.column_size) {|r,c|
          random_row_idx= random_indices[r]
          new= x_mtx[random_row_idx, c]
          new
        }
        new_y_vect= Matrix[y_vect.to_a[0].values_at(*random_indices)]

        [new_x_mtx, new_y_vect.transpose]
      end
    end
  end
end
