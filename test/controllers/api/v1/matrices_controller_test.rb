require "test_helper"

class Api::V1::MatricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    email = "test_#{SecureRandom.hex(4)}@example.com"
    @user = User.create!(
      name: "Test User",
      email: email,
      password: "password"
    )

    @matrix = [
      [ 1, 0, 1, 1 ],
      [ 0, 1, 0, 1 ],
      [ 1, 1, 1, 0 ],
      [ 1, 1, 1, 1 ]
    ]
  end

  test "returns largest submatrix of 1s when authenticated" do
    post api_v1_matrices_max_ones_url,
      params: { matrix: @matrix },
      headers: basic_auth_headers(@user.email, "password"),
      as: :json

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal [
      [ 1, 1, 1 ],
      [ 1, 1, 1 ]
    ], json["submatrix"]
  end

  test "returns 401 unauthorized when no auth" do
    post api_v1_matrices_max_ones_url,
      params: { matrix: @matrix },
      as: :json

    assert_response :unauthorized
  end

  test "returns 422 when input is invalid" do
    invalid_matrix = [
      [ 1, 0 ],
      [ 1 ]
    ]

    post api_v1_matrices_max_ones_url,
      params: { matrix: invalid_matrix },
      headers: basic_auth_headers(@user.email, "password"),
      as: :json

    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_equal "Invalid matrix. Must be a rectangular array of 0s and 1s.", json["error"]
  end

  private

  def basic_auth_headers(username, password)
    encoded = Base64.strict_encode64("#{username}:#{password}")
    { "Authorization" => "Basic #{encoded}" }
  end
end
