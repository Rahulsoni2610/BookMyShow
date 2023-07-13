class UserSerializer < ActiveModel::Serializer
  attributes :name, :email,:image

  def image
    object.image.url
  end
  
end
