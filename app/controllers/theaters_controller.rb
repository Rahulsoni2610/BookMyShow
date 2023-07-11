class TheatersController < ApplicationController
	skip_before_action :customer_authenticate_request
	before_action :owner_authenticate_request
	# before_action :find , only: [:destroy,:update]

	def index
		theater = @current_user.theaters 

		render json: theater
	end

	def create
		theater=@current_user.theaters.new(set_params)
		if theater.save
			render json: theater
		else
			render json: theater.errors.full_messages 
		end
	end

	def update
		theater = @current_user.theaters.find(params[:id])
			if theater.update(set_params)
				render json: theater 
			end
		rescue ActiveRecord::RecordNotFound
		render json: {error: "Theater not Found for this ID"}
	end

	def destroy
  	theater = @current_user.theaters.find(params[:id])
  	if theater.destroy
			render json: {message: "Theater remove successfuly"}
		end
		rescue ActiveRecord::RecordNotFound
		render json: {error: "Theater not Found for this ID"}
	end

  # def find
	# 	theater = @current_user.theaters.find(params[:id])
	# 	rescue ActiveRecord::RecordNotFound
	# 	render json: {error: "Theater not Found for this ID"}
	# end

	private
	def set_params
		params.permit(:name,:location)
	end

end
