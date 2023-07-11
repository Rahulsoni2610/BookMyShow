class CustomersController < ApplicationController
    skip_before_action :owner_authenticate_request 
    skip_before_action :customer_authenticate_request , only: [:login , :create]

	def create
		customer = Customer.new(set_params)
		if customer.save
			render json: customer
		else
			render json: customer.errors.full_messages , status: :unauthorized
		end
	end

	def login
		if customer=Customer.find_by(email: params[:email],password: params[:password])
			token= jwt_encode(customer_id: customer.id)
			render json: {token: token}, status: :ok
		else
			render json: {error: "Please provide valid Email or password"}			
		end
	end


	def search
		unless params[:name].strip.empty?
			@movie = Movie.where("name like ?", "%"+params[:name].strip+"%" )
			date=  @movie.to_a
			date = date[0][:end_date]
			if date > DateTime.now.strftime("%Y/%m?%d")
				unless @movie.nil?
					render json: @movie
			 	end
			else
			 	render json: {message: "Oops this movie is out of date"}
			end
		else
			render json: {error: "field can't be blank"}
		end
		rescue
				render json: {error: "Movie not found "}
	end

	private
	def set_params
		params.permit(:name,:email,:password)
	end

	

end
