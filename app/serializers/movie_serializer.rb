class MovieSerializer < ActiveModel::Serializer
  attributes :id,:name,:start_date,:end_date,:theater,:total_seates

  def total_seates
    object.screen.total_seats
  end


  def theater
    object.screen.theater.name
  end

end
