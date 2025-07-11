class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session # disables CSRF check

  before_action :authenticate_api_user!

  private

  # Enable HTTP Basic Auth for API
  def authenticate_api_user!
    authenticate_or_request_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user&.valid_password?(password)
        sign_in user
      else
        false
      end
    end
  end
end
