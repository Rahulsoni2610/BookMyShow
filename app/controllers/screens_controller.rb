class ScreensController < ApiController 
	before_action :set_values , only: [:destroy, :update ]
	skip_before_action :customer_check

	def index
		render json: @current_user.screens           
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
		theater =	@current_user.theaters.find_by(id: params[:theater_id])
		return render json: {error: "Theater not found"} unless theater.present?
	
		screen = @current_user.screens.new(set_params)
		if screen.save   
			render json: screen
		else
			render json: screen.errors.full_messages
		end
	end

	def update
		return render json: @screen if @screen.update(set_params)
    render json: @screen.errors.full_messages
		
	end

  def destroy
    if @screen.destroy
			render json: {message: "Screen deleted successfuly "}
		end
	end

	private
	def set_params
		params.permit(:name,:total_seats,:theater_id)
	end

	def set_values
		@screen =@current_user.screens.find_by(id: params[:id])
		rescue ActiveRecord::RecordNotFound  
		render json: {errors: "NO screen availaible for this id"}
	end		
end
