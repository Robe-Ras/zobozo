class WelcomeController < ApplicationController

  include SessionsHelper
  def index
    if logged_in?
      @user = current_user
    else
      @user = nil
    end

    @gossip = Gossip.new
    @gossips = Gossip.all
  end
 

  def index_post
    user = User.new
    user.first_name = params["first_name"]
    user.last_name = params["last_name"]
    user.save


    redirect_to root_path
  end
end
