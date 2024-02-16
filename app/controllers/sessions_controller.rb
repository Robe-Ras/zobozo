class SessionsController < ApplicationController
  include SessionsHelper
  
  before_action :authenticate_user, only: [:index]

  def index
    # on code quelque chose qui permet d'afficher le dashboard de l'utilisateur
    @current_user ||= User.find_by(id: session[:user_id])
    
    redirect_to root_path
    
  end

  

  def new
    # Créer une nouvelle instance vide d'utilisateur (si nécessaire)
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      login(user) # Utilisation de la méthode login pour connecter l'utilisateur
      flash[:success] = 'Vous êtes connecté avec succès !'
      redirect_to root_path  # Rediriger vers la page welcome/index
    else
      flash.now[:danger] = 'Adresse e-mail ou mot de passe incorrect.'
      render :new
    end
  end

  def destroy
    logout # Utilisation de la méthode logout pour déconnecter l'utilisateur
    session[:user_id] = nil # Effacer l'identifiant de session
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