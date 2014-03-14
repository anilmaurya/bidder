class Users::SessionsController < Devise::SessionsController
  def create
    user = User.find_or_initialize_by({username: params[:user][:username], guest: true})
    if user.new_record?
      user.password = SecureRandom.hex
      params[:user][:password] = user.password
      user.save
    else
      params[:user][:password] = SecureRandom.hex
    end
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(:user, user)
    redirect_to games_path 
  end

  def destroy
    current_user.destroy if current_user.guest
    super
  end

end
