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
end
