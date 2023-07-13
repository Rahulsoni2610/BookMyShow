class MoviesController < ApplicationController
  skip_before_action :customer_check
  before_action :set_value , only: [:update, :destroy]

  def index
    render json: Movie.all
  end

  def create
    screen = @current_user.screens.find_by(id: params[:screen_id])
    return render json: {error: 'screen not found'} unless screen.present?

    movie = Movie.new(set_params)
    if movie.save
      render json: movie
    else
      render json: {error: movie.errors.messages} 
    end
  end
  
  def update
    return render json: @movie if @movie.update(set_params)
    render json: @movie.errors.full_messages
  end

  def destroy
    if @movie.destroy
      render json: {message: "movie deleted successfuly"}
    end
  end

  private
  def set_params
    params.permit(:name,:start_date,:end_date,:screen_id )
  end

  def set_value
    @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: {error: "Check ID ,id not found "}
  end

end
   