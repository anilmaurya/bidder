var math;

$(document).ready(function() {

  $('#submit_bid').click(function(e){
    if(isNaN($('#bid_amount').val()) || $('#bid_amount').val() < 1){
      e.preventDefault();
      $('#entered_zero_error').modal('show');
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
    var result = ''
    if(data['win'] == 'draw'){
      result = 'Draw !!! Play Again';
    }
    else{
      result = data['winner'] + 'Won!!!';
    }
    $('#game_result').html('<div class="alert"><div class="alert-message success"><a class="close" href="#">×</a><p><strong>'+ result +'</strong> .</p></div></div>')
    $('#result').html('<div class="modal hide fade in" id="result" style="display: block;" aria-hidden="false"><div class="modal-header"><button aria-hidden="true" class="close" data-dismiss="modal" type="button">×</button> <h2> ' + result +'</h2></div> <div class="modal-body"><a href="https://twitter.com/share" class="twitter-share-button" data-url="http://playbidder.in" data-text="played bidder and its awesome !!!" data-via="playbidder" data-size="large" data-related="rubyconfindia" data-count="none">Tweet</a><a class="btn btn-primary play_again" href="/games/new">Play Again</a>    <a class="btn pull-right" data-dismiss="modal" href="#">Close</a>   </div> </div> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?"http":"https";if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document, "script", "twitter-wjs");</script>')
    $('#result').modal('show')
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
