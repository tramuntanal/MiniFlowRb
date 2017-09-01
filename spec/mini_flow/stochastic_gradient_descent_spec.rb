require_relative '../test_helper'

module MiniFlow
  describe "MiniFlow stochastic gradient descent with Housing Values in Suburbs of Boston" do

    before(:all) do
      @dataset= MiniFlow::Examples.load_boston
    end

    context "with normalized data" do
      before(:all) do
        df= @dataset
        x_df= df[:data]

        x_mtx= normalize(x_df)
        y_vect= df[:target].to_matrix

        n_features= x_df.ncols
        n_hidden= 10
        w1_mtx_= Matrix.build(n_features, n_hidden) { rand }
        b1_vect_= Matrix.zero(n_hidden)
        w2_mtx_= Matrix.build(n_hidden, 1) { rand }
        b2_vect_= Matrix.zero(1)

        ## Neural network
        x_mtx_input, y_vect_input= Layers::Input.new(), Layers::Input.new()
        w1_mtx_input, b1_vect_input= Layers::Input.new(), Layers::Input.new()
        w2_mtx_input, b2_vect_input= Layers::Input.new(), Layers::Input.new()
        
        l1= Layers::Linear.new(x_mtx_input, w1_mtx_input, b1_vect_input)
        s1= Layers::Sigmoid.new(l1)
        l2= Layers::Linear.new(s1, w2_mtx_input, b2_vect_input)
        cost= Layers::Loss::MSE.new(y_vect_input, l2)

        feed_dict = {
          x_mtx_input: x_mtx,
          y_vect_input: y_vect,
          w1_mtx_input: w1_mtx,
          b1_vect_input: b1_vect,
          w2_mtx_input: w2_mtx,
          b2_vect_input: b2_vect
        }
        
        epochs= 10
        ## Total number of examples
        m= x_mtx.row_count
        batch_size= 506
        steps_per_epoch= (m / batch_size).to_i

        graph= self.topological_sort(feed_dict)
        trainables= [w1_mtx_input, b1_vect_input, w2_mtx_input, b2_vect_input]

        puts("Total number of examples= #{m}")

        ## Step 4
        epochs.times {|idx|
          loss = 0
          steps_per_epoch.times {|j|
            # Step 1
            # Randomly sample a batch of examples
            x_mtx_batch, y_batch= resample(x_mtx, y_vect, n_samples=batch_size)
        
            # Reset value of X and y Inputs
            X.value= X_batch
            y.value= y_batch
        
            # Step 2
            self.forward_and_backward(graph)
        
            # Step 3
            sgd_update(trainables)
        
            loss+= cost.value
          }
        }

        puts("Epoch: #{i+1}, Loss:"+" %.3f" % (loss / steps_per_epoch))
      end
      it "must improve loss after each epoch" do
        
      end

      #----------------------------------------------------
      private
      #----------------------------------------------------
      def normalize(df)
        means_vect= df.mean
        means_vect.index= Daru::Index.new(0...means_vect.size)
        std_vect= df.std
        std_vect.index= Daru::Index.new(0...std_vect.size)
        mtx= ((df - means_vect) / std_vect).to_matrix
        mtx
      end

      #
      # Randomly selects the same indices from each Enumerable.
      # The number of seleced samples is determined by +n_samples+.
      #
      def resample(x_mtx, y_vect, n_samples: 1)
        raise "TODO"
      end

    end

  end
end

