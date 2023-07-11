class MoviesController < ApplicationController
  skip_before_action :customer_authenticate_request
  # before_action :find , only: [:destroy]
  def index
    movie = Movie.all
    render json: movie
  end
  
  def create
    if @current_user.screens.find_by(id: params[:screen_id])
      movie = Movie.new(set_params)
      if movie.save
        render json: movie
      else
        render json: {error: movie.errors.messages} 
      end
    else
      render json: {error: 'screen not found'}
    end
  end
  
  def update
    movie = Movie.find(params[:id])
    if movie.update(set_params)
      render json: movie
    else
      render json: {error: 'movie faild to update'} 
    end
    rescue ActiveRecord::RecordNotFound
    render json: {error: "Check ID ,id not found "}
  end

  def destroy
    movie = Movie.find(params[:id])
    if movie.destroy
      render json: {message: "movie deleted successfuly"}
    end
    rescue ActiveRecord::RecordNotFound
    render json: {error: "Check ID ,id not found "}
  end

  # def find
  #   movie = Movie.find(params[:id])
  #   byebug
  #   rescue ActiveRecord::RecordNotFound
  #   render json: {error: "Check ID ,id not found "}
  # end

  private
  def set_params
    params.permit(:name,:start_date,:end_date,:screen_id )
  end

end
   