class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!

  def auth
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      flash[:notice] = "Logged In Successfully"
      sign_in(user)
      redirect_to :games
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to root_url
    end
  end

  alias_method :twitter, :auth

end
