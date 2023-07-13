class OwnersController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :create]
  skip_before_action :owner_check, ecxept: [:index]
  skip_before_action :customer_check

  def create
    owner = Owner.new(set_params)
    owner.image.attach(params[:image])
    if owner.save
      render json: { message: 'Registration successful' }
    else
      render json: owner.errors.full_messages
    end
  end

  def login
    if owner = Owner.find_by(email: params[:email], password: params[:password])
			token = jwt_encode(user_id: owner.id)
			render json: { token: token }, status: :ok
		else
			render json: { error: 'Please provide valid Email or password' }
		end
	end

	def index
		render json: @current_user
	end

	private

	def set_params
		params.permit(:name, :email, :password, :image)
	end
end
