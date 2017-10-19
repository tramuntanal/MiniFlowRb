require 'forwardable'
module MiniFlow
  module Examples
    class TitanicModel
      extend Forwardable
      # LAYERS serves as a documentation string.
      # Example Titanic Model layers:
      #      LAYERS= <<EOLAYERS
      #- Input: [506,13]
      #- Linear: X[506,13], W[506,10], b[506]
      #- Sigmoid: [506, 1]
      #- Linear: X[506, 1], W[10,1], b[1]
      #- Cost in: y[506, 1], a[506, 1]
      #- Cost result: [1, 1]
      #EOLAYERS

      attr_reader :losses
      attr_reader :graph

      def_delegators :@model, :predict, :print_graph_arch

      def initialize
        @dataset= MiniFlow::Examples.load_titanic
      end

      def fit(epochs: 10)
        df= @dataset
        x_df= df[:data]
        y_mtx= x_df['Survived']
        x_df.delete_vector('Survived')
        x_df.summary

        x_mtx= normalize(x_df)

        n_features= x_df.ncols
        n_values= x_df.nrows
        #        batch_size= (n_values/epochs).to_i
        batch_size= 1
        n_hidden= 128
        @model= Model::Base.new([batch_size, n_features])
        @model.dense(n_hidden)
        @model.activation(:sigmoid)
        @model.dense(1)
        @model.compile(loss: :mse, optimizer: :sgd)

        puts("Total number of examples= #{n_values}")
        puts "Going to iterate #{epochs} epochs at a batch size of #{batch_size}."
        @model.fit(x_mtx, y_mtx, epochs)
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

    end
  end
end
