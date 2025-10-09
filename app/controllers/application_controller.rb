class ApplicationController < ActionController::API
  before_action :authenticate_api_key!

  private

  def authenticate_api_key!
    token = request.headers['Authorization']&.split(' ')&.last
      if token.blank? || token != ENV['THE_ONE_API_KEY']
        render json: { code: "401 Yamete Kudastop!", error: 'Do not go further or you will feel the wrath of Gimli bubble butt twerknado!!!', data: "*Gimli starts Twerking" }, status: :unauthorized
      end
  end
end
