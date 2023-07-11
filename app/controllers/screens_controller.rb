class ScreensController < ApplicationController 
	skip_before_action :customer_authenticate_request
	# before_action :find , only: [:destroy, :update ]
	def index
		screen = @current_user.screens
		render json: screen
	end

	def show
		@theater = @current_user.theaters.find_by(id: params[:id]).screens
		if @theater
			render json: @theater
		end
		rescue NoMethodError 
			render json: {errors: "NO theater availaible for this id"}
	end

	def create 
		if @current_user.theaters.find_by(id: params[:theater_id])
			screen = @current_user.screens.new(set_params)
			if screen.save   
				render json: screen
			else
				render json: screen.errors.full_messages
			end
		else
			render json: {error: "Theater not found"}
  	end
	end

	def update
		screen =@current_user.screens.find(params[:id])
		if screen.update(set_params)
			render json: screen
		end
		rescue ActiveRecord::RecordNotFound  
		render json: {errors: "NO screen availaible for this id"}
	end

  def destroy
		screen =@current_user.screens.find(params[:id])
    if screen.destroy
			render json: {message: "Screen deleted successfuly "}
		end
		rescue ActiveRecord::RecordNotFound  
		render json: {errors: "NO screen availaible for this id"}
	end

	private
	def set_params
		params.permit(:name,:total_seats,:theater_id)
	end
end
