class ShowsController < ApiController
  skip_before_action :customer_check
  before_action :set_values, only: [:destroy, :update ]

  def index
  	render json: Show.all
  end

	def create
 		screen = @current_user.screens.find_by(id: params[:screen_id])
    return render json: { error: 'Screen not found' } unless screen.present?
  
    show = Show.new(set_params)
    if show.save
      render json: show
    else
      render json: show.errors.full_messages
    end 
  end

  def update
    return render json: @show if @show.update(set_params)
    render json: @show.errors.full_messages
  end

  def destroy
    if @show.destroy
      render json: { message: 'Show deleted successfuly' }
    end
  end

  private

  def set_params
    params.permit(:start_time, :end_time, :screen_id, :movie_id)
  end

  def set_values
    @show = Show.find(params[:id])
  end
end