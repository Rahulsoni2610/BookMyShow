class BookTicketSerializer < ActiveModel::Serializer
  attributes :id, :alphanumeric_id,:total_tickets,:movie

  def movie
    object.movie.name
  end

end
