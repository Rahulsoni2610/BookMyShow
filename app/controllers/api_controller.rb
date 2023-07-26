class ApiController < ActionController::API

	include JsonWebToken
  before_action :authenticate_request
  before_action :owner_check
  before_action :customer_check

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue JWT::DecodeError
    render json: { error: 'You need to login first' }
  end

  def owner_check
    return render json: { message: 'Not a Owner' } unless @current_user.owner?
  end

  def customer_check
    return render json: { message: 'Not a customer' } unless @current_user.customer?
  end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  
  def handle_exception
    render json: { error: 'ID not found' }
  end

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
end