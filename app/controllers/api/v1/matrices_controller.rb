class Api::V1::MatricesController < Api::V1::BaseController
  protect_from_forgery with: :null_session


  # POST /api/v1/matrices/max_ones
  # Summary: Find the largest rectangular submatrix of 1's in a binary matrix.
  def max_ones
    matrix = params[:matrix]

    unless valid_matrix?(matrix)
      render json: { error: "Invalid matrix. Must be a rectangular array of 0s and 1s." }, status: :unprocessable_entity
      return
    end

    result = MaxOnesSubmatrixService.new(matrix).call

    render json: { submatrix: result }, status: :ok
  end

  private

  def valid_matrix?(matrix)
    return false unless matrix.is_a?(Array) && matrix.all? { |row| row.is_a?(Array) }

    width = matrix.first.size
    matrix.all? do |row|
      row.size == width && row.all? { |cell| cell == 0 || cell == 1 }
    end
  end
end
