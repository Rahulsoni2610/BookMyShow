class CustomersController < ApplicationController
  skip_before_action :authenticate_request , only: [:login,:create]
  skip_before_action :owner_check
  skip_before_action :customer_check ,only: [:login, :create]
  before_action :set_values , only: [:show,:update]

  def show
    render json: @user
  end

  def create
    customer = Customer.new(set_params)
    if customer.save
      render json: customer
    else
      render json: customer.errors.full_messages, status: :unauthorized
    end
  end

  def login
    if customer = Customer.find_by(email: params[:email],password: params[:password])
      token = jwt_encode(user_id: customer.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: "Please provide valid Email or password"}      
    end
  end

  def search
    @name = params[:name]
    return render json: {error: "field can't be blank"} unless @name.present?

    @movie = Movie.where("name like ?", "%"+params[:name].strip+"%" )
    date=  @movie.to_a
    date = date[0][:end_date]
    if date > DateTime.now.strftime("%Y/%m?%d")
      return render json: @movie unless @movie.nil?
    else
      render json: {message: "Oops this movie is out of date"}
    end
    rescue
    render json: {error: "Movie not found "}
  end
  
  def update
    if @user.update(set_params)
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end

  private
  def set_params
    params.permit(:name,:email,:password,:image)
  end

  def set_values
    @user = @current_user
  end

end
