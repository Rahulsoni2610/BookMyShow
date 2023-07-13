class TheaterSerializer < ActiveModel::Serializer
  attributes :id,:name,:location
  has_many :screens

  
  
end
