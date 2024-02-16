class SessionsController < ApplicationController
  include SessionsHelper
  
  before_action :authenticate_user, only: [:index]

  def index
    
    @current_user ||= User.find_by(id: session[:user_id])
    
    redirect_to root_path
    
  end

  

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      login(user) 
      flash[:success] = 'Vous êtes connecté avec succès !'
      redirect_to root_path  
    else
      flash.now[:danger] = 'Adresse e-mail ou mot de passe incorrect.'
      render :new
    end
  end

  def destroy
    logout 
    session[:user_id] = nil 
    flash[:success] = 'You have successfully logged out.'
    redirect_to root_path
  end
  

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end