class MovieSerializer < ActiveModel::Serializer
  attributes :id,:name,:start_date,:end_date
  has_many :screens

 

end
