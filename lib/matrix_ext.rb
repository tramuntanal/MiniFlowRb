# Extend Matrix with customizations for this project.
class Matrix

  # The size of a matrix is defined by the number of rows and columns that it contains.
  # [from wikipedia](https://en.wikipedia.org/wiki/Matrix_(mathematics)#Definition)
  def size
    row_count + column_count
  end

  def sizes
    [row_count, column_count]
  end
  alias_method :dimensions, :sizes
end
