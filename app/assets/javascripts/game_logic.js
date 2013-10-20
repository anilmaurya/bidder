var math;

$(document).ready(function() {
  var game_move;
  $('#bid_amount').tooltip({
    placement: 'right',
    title: 'Enter Correct Bidding Amount',
    trigger: 'manual'
  });
  console.log(pusher);
  var current_user_id = $('#current_user_id').val();
  console.log('curr use');
  
  console.log(current_user_id);
  game_move = pusher.subscribe('presence-gamemove');
  event_name = 'move_' + current_user_id;
  game_move.bind(event_name, function(data){
    alert('aaaaaaaaaaaa');
  
  });
  $('body #bid_form').submit(function(e) {
    if (check_validations(e)) {
      $('#bid_amount').attr('readonly', true);
      return $('#player_wait').show();
    } else {
      return false;
    }
  });
});
