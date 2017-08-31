require 'test_helper'

module MiniFlow
  module Examples
    describe "MiniFlow stochastic gradient descent with Housing Values in Suburbs of Boston" do

      before(:all) do
        @dataset= Examples.load_boston
      end

      it "should return data and target Matrix results" do
        expect(@dataset).not_to be_nil
        expect(@dataset[:data]).to be_kind_of(Daru::DataFrame)
        data= @dataset[:data].to_matrix
        expect(data.row_count).to eq(506)
        expect(data.column_size).to eq(13)
        expect(@dataset[:target]).to be_kind_of(Daru::Vector)
        data= @dataset[:target].to_matrix
        expect(data).to be_kind_of(Matrix)
        expect(data.row_count).to eq(1)
        expect(data.column_size).to eq(506)
      end

    end
  end
end
