# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
    $('#bid_amount').tooltip({placement: 'right', title: 'Enter Correct Bidding Amount', trigger: 'manual'})
    console.log(pusher)
    game_move = pusher.subscribe('presence-game_move')
    game_move.bind 'move_' + @current_player_id, (data) ->
      alert 'aaaaaaaaaaaa'
      if data['win']
        $('#game_result').html("#{escape_javascript(render 'game_result')}")
        $('#game_result').modal('show')
        $('#bid_form input[type="submit"]').attr('disabled', true)
        $('.play_again').show()
      else
        if data['result'] == '1'
          ele = $('.bar .object').parent().prev()
        else if data['result'] == '2'
          ele = $('.bar .object').parent().next()
        ele.html($('.object'))
        $('.player1 .badge').text("$ #{ '%02d' % @player1.current_amount}")
        $('.player2 .badge').text("$ #{ '%02d' % @player2.current_amount}")
        $('#bid_amount').attr('readonly', false)
        $('#bid_amount').val('')
        this.current_amount = data['current_amount']
      $('#player_wait').hide()

    $('body #bid_form').submit (e) ->
        if check_validations(e)
          $('#bid_amount').attr('readonly', true)
          $('#player_wait').show()
        else
          false

window.check_validations = (e) ->
    if (parseInt($('#bid_amount').val() < 0))|| (parseInt($('#bid_amount').val() < 1 && current_amount > 0)) || (current_amount - parseInt($('#bid_amount').val())) < 0
      $('#bid_amount').tooltip('show')
      false
    else
      $('#bid_amount').tooltip('hide')
      true
