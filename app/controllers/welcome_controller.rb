class WelcomeController < ApplicationController
  def index    
    if current_user
      redirect_to :games
    else
      @user = User.new
    end    
  end

  def about_us
    @contributors = Github.new.repos.contributors "anilmaurya", "bidder"
  end

  def top_bidders
    @users = User.all.order('points desc').limit(10)
  end

end
