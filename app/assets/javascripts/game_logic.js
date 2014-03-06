var math;

$(document).ready(function() {

  $('#submit_bid').click(function(e){
    if(isNaN($('#bid_amount').val()) || $('#bid_amount').val() <= 0){
      e.preventDefault();
      alert('Only values greater than 0 allowed.')
    }
  });

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
    else
    {
      console.log(data);
      username = $('#current_username').val();
      if(username == data['winner']){
        $('#result_image').html('<img src="/assets/beer_win.png">').bPopup({position: [150,300]});
      }
      else{
        $('#result_image').html('<img src="/assets/beer_lose.gif">').bPopup({position: [150,300]});
      }

      $('#game_result').html('<div class="alert"><div class="alert-message success"><a class="close" href="#">×</a><p><strong>'+ data['winner'] + '  Won!</strong>. Play Again.</p></div></div>');

      if(username == data['winner'])
      {
        $('.twitter-share-button').removeClass('hide');
      }
    }
    $('#bid_form input[type="submit"]').attr('disabled', true);
    //$('#bid_form').
    $('.play_again').show();
  } else {
    console.log(data);
    if (data['result'] == 1) {
        ele = $('.bar .object').parent().prev();
        animate_game_move('.player1');
    } else if (data['result'] == 2) {
        ele = $('.bar .object').parent().next();
        animate_game_move('.player2');
    }
    ele.html($('.object'));
    $('.player1 .badge').text("$ " + data['player_1_amount']);
    $('.player2 .badge').text("$ " + data['player_2_amount']);
    $('#bid_form').attr('action', data['new_game_move_path'])
    $('#bid_amount').attr('readonly', false);
    $('#submit_bid').attr('disabled', false)
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
