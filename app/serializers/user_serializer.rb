class UserSerializer < ActiveModel::Serializer
  attributes :email, :username, :password, :first_name, :profile_picture
end
