class ApplicationController < ActionController::API
	include JsonWebToken
	before_action :owner_authenticate_request
	before_action :customer_authenticate_request

	private
		def owner_authenticate_request
		# byebug
		  header = request.headers['Authorization']
		  header= header.split(" ").last if header
		  decoded = jwt_decode(header)
		  @current_user = User.find(decoded[:owner_id])
		rescue ActiveRecord::RecordNotFound => error
			render json: {error: "User not found" }
		rescue JWT::DecodeError => error
			render json: {error: "You need to login first" }
		end
		
	private
		def customer_authenticate_request
		  # byebug
		  header = request.headers['Authorization']
		  header= header.split(" ").last if header
		  decoded = jwt_decode(header)
		  @current_customer = User.find(decoded[:customer_id])
		rescue ActiveRecord::RecordNotFound => error
			render json: {error: "User not found" }
		rescue JWT::DecodeError => error
			render json: {error: "You need to login first" }
		end
end
