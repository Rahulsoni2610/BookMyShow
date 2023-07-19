class BookTicketSerializer < ActiveModel::Serializer
  attributes :id, :alphanumeric_id, :total_tickets, :movie, :theater

  def movie
    object.movie.name
  end

  def theater
    object.theater.name
  end
end
