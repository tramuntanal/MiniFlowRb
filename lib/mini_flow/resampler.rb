module MiniFlow
  class Resampler
    
    #
    # Extracts a randomized sample of elements of a list of structs. Being each
    # struct, an Enumerable structure like an Array or a Matrix.
    # 
    # This is, given a number of structs it first determines the range of elements
    # (this is the page or sample) and a list of random indices in this sample,
    # and for each structure it extract the given page performs the same mix up of elements.
    # 
    # 
    # The sample can be paginated, being +iter+ the page number and +batch_size+
    # the number of elements per page.
    #
    # Arguments
    # @param [structs] The structures to be resampled. Either Arrays or DataFrames.
    # @param [iter] defaults to 1. Is the iteration number starting at 1.
    # @param [batch_size] defaults to the number of elements in the first stucture.
    #
    def resample_batch(structs, iter: 1, batch_size: nil)
      structs= [structs] unless structs.kind_of?(Array)
      batch_size= structs.first.size unless batch_size

      first_idx= (iter-1)*batch_size
      last_idx= first_idx+batch_size
      range= (first_idx...last_idx)
      random_indices= range.to_a.sample(batch_size)
      rs= structs.collect {|struct|
        if struct.kind_of?(Array)
          random_indices.collect {|idx| struct[idx] }
        elsif struct.kind_of?(Daru::DataFrame)
#          struct.row[*random_indices]
          struct.filter_rows.with_index {|row,idx| random_indices.include?(idx)}
        elsif struct.kind_of?(Matrix)
          rows= random_indices.collect {|idx| struct.row(idx).to_a }
          Matrix.rows(rows)
        else
          raise NotImplementedError, "Resampling for #{struct.class} structures is not supported."
        end
      }
      rs
    end
  end
end
