class OwnersController < ApplicationController
	skip_before_action :owner_authenticate_request , only: [:login, :create]
  skip_before_action :customer_authenticate_request

  	def create
		owner = Owner.new(set_params)
		if owner.save
			render json: owner
		else
			render json: {error: owner.errors.full_messages } 
		end
	end

	def login
		if owner=Owner.find_by(email: params[:email],password: params[:password])
			token= jwt_encode(owner_id: owner.id)
			render json: {token: token}, status: :ok
		else
			render json: {error: "Please provide valid Email or password" }			
		end
	end

	private
	def set_params
		params.permit(:name,:email,:password)
	end
end
