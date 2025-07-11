# app/services/max_ones_submatrix_service.rb

# Service to find the largest rectangle of 1’s in a binary matrix.
# Uses a row-wise histogram + stack-based largest rectangle algorithm.
class MaxOnesSubmatrixService
  # Struct to store information about the best rectangle found.
  # :area  -> total area of rectangle
  # :top, :left -> top-left corner of rectangle
  # :bottom, :right -> bottom-right corner of rectangle
  Result = Struct.new(:area, :top, :left, :bottom, :right)

  def initialize(matrix)
    # Input matrix: 2D array of 0’s and 1’s
    @matrix = matrix
  end

  # Main method to find the largest rectangle of 1’s.
  # Returns the submatrix (2D array) representing the largest rectangle.
  def call
    return [] if @matrix.blank? || @matrix[0].blank?

    n = @matrix.size            # number of rows
    m = @matrix[0].size         # number of columns
    heights = Array.new(m, 0)   # histogram heights per column
    max_result = Result.new(0, 0, 0, 0, 0)  # stores best rectangle found

    # Iterate through each row to build histograms row by row
    (0...n).each do |row|
      (0...m).each do |col|
        # If current cell is 1, increment histogram height
        # Otherwise, reset to 0
        if @matrix[row][col] == 1
          heights[col] += 1
        else
          heights[col] = 0
        end
      end

      # Find largest rectangle in the current histogram
      area, left, right, height = largest_rectangle_in_histogram(heights)

      # Update max_result if a bigger rectangle is found
      if area > max_result.area
        max_result.area = area
        max_result.top = row - height + 1
        max_result.bottom = row
        max_result.left = left
        max_result.right = right
      end
    end

    # Extract the submatrix from the original matrix using best rectangle coordinates
    extract_submatrix(max_result)
  end

  private

  # Finds the largest rectangle area in a given histogram of heights.
  # Uses a stack to keep track of increasing heights.
  # Returns:
  # [max_area, left_col, right_col, height_of_rectangle]
  def largest_rectangle_in_histogram(heights)
    stack = []
    max_area = 0
    left = right = height = 0

    # Add sentinel 0 to flush out remaining stack at the end
    heights_with_sentinel = heights + [ 0 ]

    heights_with_sentinel.each_with_index do |h, i|
      # While current height < height at stack top → pop and compute area
      while !stack.empty? && h < heights_with_sentinel[stack[-1]]
        top = stack.pop
        h_top = heights_with_sentinel[top]
        w = stack.empty? ? i : i - stack[-1] - 1
        area = h_top * w
        if area > max_area
          max_area = area
          left = stack.empty? ? 0 : stack[-1] + 1
          right = i - 1
          height = h_top
        end
      end
      stack << i
    end

    [ max_area, left, right, height ]
  end

  # Builds and returns the submatrix corresponding to the largest rectangle.
  def extract_submatrix(result)
    return [] if result.area == 0

    submatrix = []
    (result.top..result.bottom).each do |i|
      row = []
      (result.left..result.right).each do |j|
        row << @matrix[i][j]
      end
      submatrix << row
    end
    submatrix
  end
end
