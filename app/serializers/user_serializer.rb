class UserSerializer < ActiveModel::Serializer
  attributes :email, :username, :first_name, :profile_picture
end
