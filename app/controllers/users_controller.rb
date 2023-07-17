class UsersController < ApiController
  skip_before_action :authenticate_request
  skip_before_action :owner_check
  skip_before_action :customer_check

  def login
    if users = User.find_by(email: params[:email],password: params[:password])
      token = jwt_encode(user_id: users.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: "Please provide valid Email or password"}      
    end
  end

end

