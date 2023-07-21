class BookTicketsController < ApplicationController
  skip_before_action :owner_check

  def index
    book = @current_user.book_tickets
  return render json: book if book.present?
   
   render json: {message: "Nothing in your cart"}
  end

  def search_ticket
    a_id = params[:alphanumeric_id]
    return render json: { error: "provide details" } unless a_id.present?

    a_id = BookTicket.find_by(alphanumeric_id: params[:alphanumeric_id])
    unless a_id.nil?
     render json: a_id
    else
      render json: { errors: "sorry no ticket avaliable for your search" }
    end
  end

	def create
    screen = Screen.find_by(movie_id:params[:movie_id], theater_id:params[:theater_id])

    book = @current_user.book_tickets.new(set_params)
    return render json: book.errors.full_messages unless book.valid?

    if screen.total_seats > book.total_tickets
      book.save
      screen.update(total_seats: screen.total_seats - book.total_tickets)
      render json: { message: "tickets booked" }
    else
      render json: { error: 'Oops #{total_seats} seats available' }
    end
  rescue NoMethodError
    render json: { message: 'movie is not present in this theater' }
	end

  private

	def set_params
		params.permit(:total_tickets, :movie_id, :theater_id)
	end
end