# Extend Matrix with customizations for this project.
class Matrix

  # The size of a matrix is defined by the number of rows and columns that it contains.
  # [from wikipedia](https://en.wikipedia.org/wiki/Matrix_(mathematics)#Definition)
  def size
    row_count + column_size
  end

  # @returns An array with the counts of the rows and columns.
  def sizes
    [row_count, column_size]
  end
  alias_method :dimensions, :sizes

  # @returns An array with the sums of the rows of the Matrix.
  def inner_row_sum
    Vector[*row_vectors.collect {|row| row.element_sum}]
  end

  # @returns A new Matrix which has the same content as _current_, but without the given column.
  def remove_column(idx)
    arrays= to_a.transpose
    arrays.delete_at(idx)
    Matrix.rows(arrays.transpose)
  end
end

class Vector
  # This method is in Ruby's 2.4.1 documentation but inexistent in the runtime.
  #
  # @return A new Vector with *num_elems* size and all elements set to zero.
  def self.zero(num_elems)
    Vector[*num_elems.times.collect {0.0}]
  end
  # @return The sum of the Vector elements.
  def element_sum
    to_a.inject(:+)
  end
end