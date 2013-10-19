class UsersController < ApplicationController
  
  protect_from_forgery :except => :pusher_authentication
  before_filter :authenticate_user!
   
  def pusher_authentication
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id.to_s, # => required
        :user_info => { # => optional - for example
          :name => current_user.username
        }
      })
      Rails.logger.info "response #{response.inspect}"
      render :json => response
    else
      render :text => "Forbidden", :status => '403'
    end
  end
end
