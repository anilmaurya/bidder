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
    var ele;
  console.log('event fired')
  console.log(data)
  if (data['winner']) {
    if(data['win'] == 'draw'){
    $('#game_result').html('<div class="alert"><div class="alert-message success"><a class="close" href="#">×</a><p><strong>Draw!!! Play Again</strong> .</p></div></div>')
    }
    else{
    $('#game_result').html('<div class="alert"><div class="alert-message success"><a class="close" href="#">×</a><p><strong>'+ data['winner'] + '  Won!</strong>. Play Again.</p></div></div>')
    }
    $('#bid_form input[type="submit"]').attr('disabled', true);
    $('.play_again').show();
  } else {
    console.log(data);
    if (data['result'] == 1) {
        ele = $('.bar .object').parent().prev();
    } else if (data['result'] == 2) {
        ele = $('.bar .object').parent().next();
    }
    ele.html($('.object'));
    $('.player1 .badge').text("$ " + data['player_1_amount']);
    $('.player2 .badge').text("$ " + data['player_2_amount']);
    $('#bid_form').attr('action', data['new_game_move_path'])
    $('#bid_amount').attr('readonly', false);
    $('#bid_amount').val('');
    this.current_amount = data['current_amount'];
  }

  $('#player_wait').hide();
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
