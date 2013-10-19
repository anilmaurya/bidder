$(document).ready(function(){
  $('#new_game_invite').bind('ajax:complete', function(evt, data, status, xhr) {
    var $form, alert_modal;
    $form = $(this);
    alert_modal = "" 
    console.debug(evt);
    console.debug(data);
    console.debug(xhr);
    if(status == "success")
    {
      alert_modal = "<div class='alert fade in'>";
      alert_modal = alert_modal + "<button class='close' data-dismiss='alert' type='button'>x </button>";
      alert_modal = alert_modal + "Your invite request sent to other user successfully. Please Don't refresh page.";
      alert_modal = alert_modal + "</div>";
    }
    else
    {
        
    }
  });
});
