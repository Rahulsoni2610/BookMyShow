class ScreensController < ApiController
  before_action :set_values, only: [:destroy, :update, :refresh ]
  skip_before_action :customer_check

  def index
    render json: @current_user.screens
  end

  def show
    theater = @current_user.theaters.find_by(id: params[:id])&.screens
    return render json: theater if theater.present?
      
    render json: { message: 'There is no screen present in this theater' }
  end

  def create
    theater = @current_user.theaters.find_by(id: params[:theater_id])
    return render json: { error: 'Theater not found' } unless theater.present?
  
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
      render json: { message: 'Screen deleted successfuly' }
    end
  end

  def refresh
    shows = @screen.show
    return render json: { message: "Screen does not have any show" } unless shows.present?
  
    if Time.now.strftime("%H:%M") > shows.end_time
      @screen.update(total_seats:25)
      shows.destroy
      render json: { message:"Screen Refreshed"}
    end
  end

  private

  def set_params
    params.permit(:name, :total_seats, :theater_id)
  end

  def set_values
    @screen = @current_user.screens.find(params[:id])
  end
end
