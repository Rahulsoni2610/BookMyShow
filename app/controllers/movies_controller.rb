class MoviesController < ApiController
  skip_before_action :customer_check
  before_action :owner_check, except: [:search_movie]
  before_action :set_value, only: [:update, :destroy]

  def index
    render json: Movie.all
  end

  def create
    movie = Movie.create(set_params)
    if movie.save
      render json: movie
    else
      render json: movie.errors.messages
    end
  end
  
  def update
    return render json: @movie if @movie.update(set_params)
    render json: @movie.errors.full_messages
  end

  def destroy
    if @movie.destroy
      render json: { message: 'movie deleted successfuly' }
    end
  end

  def search_movie
    @name = params[:name]
    return render json: { error: "field can't be blank" } unless @name.present?

    @movie = Movie.where("name like ?", "%"+params[:name]+"%" )
    date = @movie[0][:end_date]
    if date > DateTime.now.strftime("%Y/%m?%d")
      return render json: @movie unless @movie.nil?
    else
      render json: { message: "Oops this movie is out of date" }
    end
    rescue NoMethodError
    render json: { error: "Movie not found " }
  end

  private

  def set_params
    params.permit(:name, :start_date, :end_date)
  end

  def set_value
    @movie = Movie.find(params[:id])
  end
end