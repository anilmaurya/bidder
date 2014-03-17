$(document).ready(function(){

  $('#new_game_invite').bind('ajax:complete', function(evt, data, status, xhr) {
    var $form, alert_modal;
    $form = $(this);
    alert_modal = ""
    console.debug(evt);
    console.debug(data);
    console.debug(xhr);
    response_txt = JSON.parse(data.responseText)
    $('.alert').remove();
    if(status == "success" && response_txt['valid'])
    {
      alert_modal = "<div class='alert'>";
      alert_modal = alert_modal + "<button class='close' data-dismiss='alert' type='button'>x </button>";
      alert_modal = alert_modal + "Your invite request sent to other user successfully. Please Don't refresh page.";
      alert_modal = alert_modal + "</div>";
      //$form.find('.form-actions input[type="Submit"]').attr('disabled', 'disabled');
      $('#new_game_invite').find('.form-actions .btn-warning').attr('disabled', 'disabled');
    }
    else
    {
      alert_modal = "<div class='alert alert-error'>";
      alert_modal = alert_modal + "<button class='close' data-dismiss='alert' type='button'>x </button>";
      alert_modal = alert_modal + response_txt['message'];
      alert_modal = alert_modal + "</div>";
    }
    $('.container .row').before(alert_modal);
    $('.alert').alert();
  });

  current_user_id = $('#current_user_id').val();
  game_invite = pusher.subscribe('presence-game_invite');
  game_invite.bind('invite_from_user', function(data){
    console.log('checking invite from user');
    current_user_id = $('#current_user_id').val();
    console.log(data['to']);
    console.log(data['game_invite']);
    console.log(data['game_invite']['$oid']);
    console.log(current_user_id);
    if(data['to']["$oid"] == current_user_id)
    {
      div_alert_block = "<div class='alert alert-block invitation_link' data-no-turbolink>";
      div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
      div_alert_block = div_alert_block + "<h4 class='alert-heading'> Got Invitation from " + data["from_username"]  + "</h4>";
      div_alert_block = div_alert_block + "<p> Once You accept game invitation you will be get link to join Game. You can reject also if you does not want to play</p>";
      div_alert_block = div_alert_block + "<p> <a class='btn btn-success accept_invitation' href='#' data-url=/game_invites/" + data['game_invite']["$oid"]  + "/accept_invitation> Accept Game Invitation </a> &nbsp;";
      div_alert_block = div_alert_block + "<a class='btn btn-danger reject_invitation' href='#' data-url=/game_invites/" + data['game_invite']["$oid"]  + "/reject_invitation > Reject Game Invitation </a></p>";
      div_alert_block = div_alert_block +  "</div>";
      console.log(div_alert_block);
      $('.container .row').before(div_alert_block);
      $('.invitation_link').alert();
    }
  });

  $('body .container:last').on("click", '.accept_invitation', function(){
    $.ajax({
      type: 'GET',
      url: $('.accept_invitation').data('url'),
      success: function(data){
        json_data = data;

        game_show_link = "<a  href=/games/" + data["game_id"] + "> Click on link to join game </a>" ;
        div_alert_block = "<div class='alert alert-block click_game_link'>";
        div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
        div_alert_block = div_alert_block + "<h4 class='alert-heading'> Join Game</h4>";
        div_alert_block = div_alert_block + "<p> " + game_show_link + "</p>";
        div_alert_block = div_alert_block + "<p> Do not leave or refresh page. Your game will lost</p>";
        div_alert_block = div_alert_block +  "</div>";
        $('.invitation_link').remove();
        $('.container .row').before(div_alert_block);
        $('.click_game_link').alert();
      },

      error: function(data){
        alert('Contact Admin');
      }
    });

  });

  $('body .container:last').on("click", '.reject_invitation', function(){
    $.ajax({
      type: 'GET',
      url: $('.reject_invitation').data('url'),
      success: function(data){
        $('.invitation_link').remove();
      },
      error: function(data){
        alert('error occur on server, contact admin');
      }
    });

  });

  game_invite.bind('accepted_' + current_user_id, function(data){
    game_show_link = "<a  href=/games/" + data["game_id"]["$oid"] + "> Click on link to join game </a>" ;
    div_alert_block = "<div class='alert alert-block accepted_game_link'>";
    div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
    div_alert_block = div_alert_block + "<h4 class='alert-heading'> Game Invitation Accepted</h4>";
    div_alert_block = div_alert_block + "<p> Game invitation to " + data["from_username"] +" got accepted." + game_show_link + "</p>";
    div_alert_block = div_alert_block + "<p> Do not leave or refresh page. Your game will lost</p>";
    div_alert_block = div_alert_block +  "</div>";
    console.log('pusher accepting invitation');
    $('.container .row').before(div_alert_block);
    $('.accepted_game_link').alert();
  });

  game_invite.bind('rejected_' + current_user_id, function(data){
    div_alert_block = "<div class='alert rejected_invitation'>";
    div_alert_block = div_alert_block + "<button class='close' data-dismiss='alert' type='button'> x </button>";
    div_alert_block = div_alert_block + "<h4 class='alert-heading'> Reject Invitation from " + data["from_username"]  + "</h4>";
    div_alert_block = div_alert_block + "<p> Your game invitation get rejected</p>";
    div_alert_block = div_alert_block +  "</div>";

    $('.container .row').before(div_alert_block);

    $('.rejected_invitation').alert();
    console.log('game invitation got rejected');
  });

});
