$(document).ready(function(){
  game_invite = pusher.subscribe('presence-game_invite');                
  game_invite.bind('invite_from_user', function(data){
    current_user_id = $('#current_user_id').val();
    if(data['to'] == current_user_id)
    {
      div_alert_block = "<div class='alert alert-block invitation_link'>";
      div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
      div_alert_block = div_alert_block + "<h4 class='alert-heading'> Got Invitation from " + data["from_username"]  + "</h4>";
      div_alert_block = div_alert_block + "<p> Once You accept game invitation you will be redirected to new page. You can reject also if you does not want to play</p>";
      div_alert_block = div_alert_block + "<p> <a class='btn btn-success accept_invitation' href='#'> Accept Game Invitation </a>";
      div_alert_block = div_alert_block + "<a class='btn btn-danger reject_invitation' href='#'> Reject Game Invitation </a></p>";
      div_alert_block = div_alert_block +  "</div>";
      console.log(div_alert_block); 
      $('.container .row').before(div_alert_block);
      $('.invitation_link').alert();
    }  
  });

  
});
