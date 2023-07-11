class BookTicketsController < ApplicationController	
	skip_before_action :owner_authenticate_request 
  before_action :customer_authenticate_request 

  def index
   book = @current_customer.book_tickets
   render json: book 
  end

  def search
    unless params[:alphanumeric_id].strip.empty?
      a_id = BookTicket.find_by(alphanumeric_id: params[:alphanumeric_id])
      unless a_id.nil?
       render json: a_id
      else
        render json: {errors: "sorry no ticket avaliable for your search"}
      end
    else
      render json: {error: "provide details"}
    end
    rescue 
      render json: {error: "provide details"}
  end

	def create 
		temp= Theater.find_by(name: params[:theater_name])
		unless temp.nil?
	    @book = @current_customer.book_tickets.new(set_params)
      if @book.valid?
        update_seats()
        if @total_seats > @tickets
          @book.save
          @screen.update(total_seats: @total_seats- @tickets)
          render json: {message: "tickets booked"}
        else 
          render json: {error: "Oops #{@total_seats} seats available "} 
        end
      else
        render json: @book.errors.full_messages
      end
	  else 
	  	render json: {error: "Theater Not Found"}
	  end
	end

  def update_seats
    @seats = Movie.find_by(id: params[:movie_id])
    @seats = @seats.screen_id
    @screen = Screen.find(@seats)
    @total_seats=@screen.total_seats
    @tickets = @book.total_tickets
  end

	def set_params
		params.permit(:total_tickets,:movie_id,:theater_name)
	end
end
