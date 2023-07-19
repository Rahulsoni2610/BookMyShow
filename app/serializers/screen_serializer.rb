class ScreenSerializer < ActiveModel::Serializer
  attributes :id ,:name, :total_seats
  belongs_to :movie
end
