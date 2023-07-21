class TheatersController < ApplicationController
  before_action :set_values, only: [:destroy, :update]
  skip_before_action :customer_check

  def index
    render json: @current_user.theaters
  end

  def create
    theater = @current_user.theaters.new(set_params)
    if theater.save
      render json: theater
    else
      render json: theater.errors.full_messages
    end
  end

  def update
    return render json: @theater if @theater.update(set_params)
    render json: @theater.errors.full_messages
  end

  def destroy
    return render json: { message: 'Theater remove successfuly' } if @theater.destroy
    render json: { message: 'Theater not removed' }
  end

  private

  def set_params
    params.permit(:name, :location)
  end

  def set_values
    @theater = @current_user.theaters.find(params[:id])
  end
end
