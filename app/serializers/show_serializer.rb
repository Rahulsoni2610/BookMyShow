class ShowSerializer < ActiveModel::Serializer
  attributes :id , :movie, :start_time, :end_time, :theater

  def theater
    object.screen.theater.name
  end
  def movie
    object.movie.name
  end
end
