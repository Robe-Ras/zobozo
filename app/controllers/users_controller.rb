class UsersController < ApplicationController
  include SessionsHelper
  def show
    @user = User.find(params[:id])
  end


  def new 
    @user = User.new
    @cities = City.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully!"
      redirect_to new_session_path
    else
      flash.now[:error] = "Failed to create user."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :city_id, :email, :password)
  end
  
end
