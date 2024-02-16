class GossipsController < ApplicationController
  include SessionsHelper
  before_action :authenticate_user, only: [:create, :new, :edit, :update, :destroy]

  
  def index
    @gossips = Gossip.all
  end

  
  def show
    @gossip = Gossip.find(params[:id])
  end
  

  def new 
    @gossip = Gossip.new 
  end


  def edit
    @gossip = Gossip.find(params[:id])
  end


  def update
    @gossip = Gossip.find(params[:id])
    
    if @gossip.update(post_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  def create
    @gossip = Gossip.create(post_params)
    @gossip.user = User.find_by(id: session[:user_id])
    if @gossip.save
      flash[:success] = "Potin bien créé !"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path, notice: 'Gossip was successfully destroyed.'
  end

private

  def post_params
    post_params = params.permit(:title, :content)
  end
  
  

  
end
