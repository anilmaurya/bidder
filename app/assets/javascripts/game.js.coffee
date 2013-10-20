# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
    $('#bid_amount').tooltip({placement: 'right', title: 'Enter Correct Bidding Amount', trigger: 'manual'})
    ele = $('.object')
    if window.level
      $(".bar_holder .bar:nth-child(#{window.level})").html(ele)
    $('body #bid_form').submit (e) ->
        if check_validations(e)
          $('#bid_amount').attr('readonly', true)
          $('#player_wait').show()
        else
          false

window.check_validations = (e) ->
    if ($('#bid_amount').val() == "") || (parseInt($('#bid_amount').val() < 0))|| (parseInt($('#bid_amount').val() < 1 && current_amount > 0)) || (current_amount - parseInt($('#bid_amount').val())) < 0
      $('#bid_amount').tooltip('show')
      false
    else
      $('#bid_amount').tooltip('hide')
      true
