class ApiController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request
  before_action :owner_check
  before_action :customer_check

  private

    def authenticate_request
      header = request.headers['Authorization']
      header= header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: "User not found" }
    rescue JWT::DecodeError => error
      render json: { error: "You need to login first" }
    end

    def owner_check
      return render json: { message: "Not a Owner" } unless @current_user.owner? 
    end

    def customer_check
      return render json: { message: "Not a customer" } unless @current_user.customer? 
    end

    before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
    end
end