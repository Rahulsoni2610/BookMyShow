class BookTicketSerializer < ActiveModel::Serializer
  attributes :id, :alphanumeric_id, :total_tickets, :screen
  belongs_to :show

  def screen
    object.show.screen.name
  end
end
