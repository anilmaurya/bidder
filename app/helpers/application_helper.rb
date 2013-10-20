module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def show_pending_invitation_request(invitation_request)
    div_alert_block = '' 
    if  invitation_request
      from_username = invitation_request.sender_user.username
      div_alert_block = "<div class='alert alert-block invitation_link'>";
      div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
      div_alert_block = div_alert_block + "<h4 class='alert-heading'> Got Invitation from " + from_username  + "</h4>";
      div_alert_block = div_alert_block + "<p> Once You accept game invitation you will be redirected to new page. You can reject also if you does not want to play</p>";
      div_alert_block = div_alert_block + "<p> <a class='btn btn-success accept_invitation' href='#'> Accept Game Invitation </a>";
      div_alert_block = div_alert_block + "<a class='btn btn-danger reject_invitation' href='#'> Reject Game Invitation </a></p>";
      div_alert_block = div_alert_block +  "</div>";
    end
    div_alert_block.html_safe
  end
end
