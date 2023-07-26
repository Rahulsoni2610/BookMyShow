class BookTicketsController < ApiController
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
    screen_update()
    return render json: @book.errors.full_messages unless @book.valid?
    return render json: {message: "Show has ended"} if Time.now.strftime("%H:%M") > @show.end_time
      
    return  render json: { error: "Oops #{@total_seats} seats available" } if @total_seats < @book.total_tickets 
    
    @book.save
    @screen.update(total_seats: @total_seats - @book.total_tickets)
    render json: { message: 'tickets booked' }
  end

  def screen_update
    @screen = Screen.joins(:show).find_by(id: params[:show_id])
    @total_seats = @screen&.total_seats 
    @book = @current_user.book_tickets.new(set_params)
    @show = Show.find_by(id: params[:show_id]) 
  end

  private

  def set_params
    params.permit(:total_tickets, :show_id)
  end
end