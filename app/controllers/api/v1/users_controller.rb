class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  
  def create
    debugger
    @user = User.create(user_params)
    @user.email = @user.email.downcase
    @user.save

    if @user.valid?
      @token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end
  
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  private

  def user_params
    params.permit(:email, :username, :password, :first_name, :profile_picture)
  end

end
