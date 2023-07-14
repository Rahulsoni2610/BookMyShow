class BookTicketsController < ApiController	
  skip_before_action :owner_check

  def index
   book = @current_user.book_tickets
   render json: book 
  end

  def search
    a_id = params[:alphanumeric_id]
    return render json: {error: "provide details"} unless a_id.present?

    a_id = BookTicket.find_by(alphanumeric_id: params[:alphanumeric_id])
    unless a_id.nil?
     render json: a_id
    else
      render json: {errors: "sorry no ticket avaliable for your search"}
    end
    rescue NoMethodError
    render json: {error: "select field"}
  end

	def create 
    @book = @current_user.book_tickets.new(set_params)
    return render json: @book.errors.full_messages unless @book.valid?

      update_seats()
      if @total_seats > @tickets
        @book.save
        @screen.update(total_seats: @total_seats- @tickets)
        render json: {message: "tickets booked"}
      else 
        render json: {error: "Oops #{@total_seats} seats available "} 
      end
	end

  def update_seats
    @seats = Movie.where(id: params[:movie_id]).first.screen_id
    @screen = Screen.find(@seats)
    @total_seats=@screen.total_seats
    @tickets = @book.total_tickets
  end

  private
	def set_params
		params.permit(:total_tickets,:movie_id)
	end

end
