class UsersController < ApiController
  skip_before_action :authenticate_request, except: [:show, :update]
  skip_before_action :customer_check
  skip_before_action :owner_check

  def show
    render json: @current_user
  end

  def create
    user = User.new(set_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unauthorized
    end
  end
  
  def update
    if @current_user.update(set_params)
      render json: @current_user
    else
      render json: @current_user.errors.full_messages
    end
  end

  def login
    if user = User.find_by(email: params[:email],password: params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Please provide valid Email or password' }
    end
  end

  private

  def set_params
    params.permit(:name, :email, :password, :type, :image)
  end
end