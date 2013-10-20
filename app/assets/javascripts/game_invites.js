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


});
