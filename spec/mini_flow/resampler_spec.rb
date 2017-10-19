require_relative '../test_helper'

module MiniFlow
  describe Resampler do

    before(:all) do
      @resampler= Resampler.new
    end

    describe "when working with arrays" do
      it "Should return the elements at the same indices for each of the arrays" do
        when_resampling_many_array_structures
        all_subsampled_array_elements_should_correspond_to_the_same_indices
      end
    end
    describe "when working with dataframes" do
      it "Should return the elements at the same indices for each of the dataframes" do
        when_resampling_many_dataframe_structures
        all_subsampled_dataframe_rows_should_correspond_to_the_same_indices
      end
    end
    describe "when working with matrices" do
      it "Should return the elements at the same indices for each of the matrices" do
        when_resampling_many_matrix_structures
        all_subsampled_matrix_rows_should_correspond_to_the_same_indices
      end
    end

    #-----------------------------------------------
    private
    #-----------------------------------------------

    def when_resampling_many_array_structures
      @ary_1= (1..10).to_a
      @ary_2= (10..20).to_a
      @rs_1, @rs_2= @resampler.resample_batch([@ary_1, @ary_2], iter: 2, batch_size: 5)
    end
    def when_resampling_many_dataframe_structures
      @df_1= Daru::DataFrame.new([[1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3],[2,3,4,1]])
      @df_2= Daru::DataFrame.new([%i[a b c d],%i[b c d a],%i[c d a b],%i[d a b c],%i[a b c d]])
      @rs_1, @rs_2= @resampler.resample_batch([@df_1, @df_2], iter: 1, batch_size: 3)
    end
    def when_resampling_many_matrix_structures
      @mtx_1= Matrix.rows([[1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3],[2,3,4,1]])
      @mtx_2= Matrix.rows([%i[a b c d],%i[b c d a],%i[c d a b],%i[d a b c],%i[a b c d]])
      @rs_1, @rs_2= @resampler.resample_batch([@mtx_1, @mtx_2], iter: 2, batch_size: 2)
    end
    def all_subsampled_array_elements_should_correspond_to_the_same_indices
      expect(@rs_1.size).to eq 5
      subsample= (5..10).to_a
      check_same_elements_different_order(subsample, @rs_1)

      expect(@rs_2.size).to eq 5
      subsample= (15..20).to_a
      check_same_elements_different_order(subsample, @rs_2)
    end
    def all_subsampled_dataframe_rows_should_correspond_to_the_same_indices
      expect(@rs_1.size).to eq 3
      expect(@rs_2.size).to eq 3
      ary= @df_1.to_a
      idxs_1= @rs_1.collect {|elem| ary.index(elem) }
      ary= @df_2.to_a
      idxs_2= @rs_2.collect {|elem| ary.index(elem) }
      expect(idxs_1).to eq(idxs_2)
    end
    def all_subsampled_matrix_rows_should_correspond_to_the_same_indices
      expect(@rs_1.row_count).to eq 2
      expect(@rs_2.row_count).to eq 2
      idxs_1= @rs_1.collect {|elem| @mtx_1.index(elem) }
      idxs_2= @rs_2.collect {|elem| @mtx_2.index(elem) }
      expect(idxs_1).to eq(idxs_2)
    end

    def check_same_elements_different_order(ary_1, ary_2)
      expect(ary_1).not_to eq ary_2
      ary_1.each {|item| ary_2.delete(item)}
      expect(ary_2.empty?).to be true
    end

  end
end

