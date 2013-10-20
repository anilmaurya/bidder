$(document).ready(function(){
  
  current_user_id = $('#current_user_id').val();
  game_invite = pusher.subscribe('presence-game_invite');                
  game_invite.bind('invite_from_user', function(data){
    current_user_id = $('#current_user_id').val();
    if(data['to'] == current_user_id)
    {
      div_alert_block = "<div class='alert alert-block invitation_link'>";
      div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
      div_alert_block = div_alert_block + "<h4 class='alert-heading'> Got Invitation from " + data["from_username"]  + "</h4>";
      div_alert_block = div_alert_block + "<p> Once You accept game invitation you will be redirected to new page. You can reject also if you does not want to play</p>";
      div_alert_block = div_alert_block + "<p> <a class='btn btn-success accept_invitation' href='#' data-url=/game_invites/" + data['game_invite']  + "/accept_invitation> Accept Game Invitation </a>";
      div_alert_block = div_alert_block + "<a class='btn btn-danger reject_invitation' href='#' data-url=/game_invites/" + data['game_invite']  + "/reject_invitation > Reject Game Invitation </a></p>";
      div_alert_block = div_alert_block +  "</div>";
      console.log(div_alert_block); 
      $('.container .row').before(div_alert_block);
      $('.invitation_link').alert();
    }  
  });

  $('body .container:last').on("click", '.accept_invitation', function(){
    $.ajax({
      type: 'GET', 
      url: ''
    }); 
       
  }); 

  $('body .container:last').on("click", '.reject_invitation', function(){
    $.ajax({
      type: 'GET', 
      url: ''
    }); 
       
  });

  game_invite.bind('accepted_' + current_user_id, function(data){
    game_show_link = "/game/" + data["game_id"] + "/show";
    div_alert_block = "<div class='alert alert-block accepted_game_link'>";
    div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
    div_alert_block = div_alert_block + "<h4 class='alert-heading'> Game Invitation Accepted</h4>";
    div_alert_block = div_alert_block + "<p> Game invitation to " + data["from_username"] +" got accepted. Click on link " + game_show_link + " to join game</p>";
    div_alert_block = div_alert_block + "<p> Do not leave or refresh page. Your game will lost</p>";
    div_alert_block = div_alert_block +  "</div>";
    console.log('pusher accepting invitation');  
    
    $('.container .row').before(div_alert_block);
    
  }); 

  game_invite.bind('rejected_' + current_user_id, function(data){
    div_alert_block = "<div class='alert rejected_invitation'>";
    div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
    div_alert_block = div_alert_block + "<h4 class='alert-heading'> Reject Invitation from " + data["from_username"]  + "</h4>";
    div_alert_block = div_alert_block + "<p> Your game invitation get rejected</p>";
    div_alert_block = div_alert_block +  "</div>";
    console.log('game invitation got rejected');  
  });  

});
