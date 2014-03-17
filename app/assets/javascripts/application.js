// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require pusher
//= require bootstrap-select.min
//= require game
//= require jquery.bpopup.min
//= require jquery.transit.min
$(document).ready(function(){
  Pusher.host = '54.186.39.143'
  Pusher.httpHost = '54.186.39.143'
  Pusher.ws_port = '8080'
  Pusher.wss_port = '8080'
  window.pusher = new Pusher(PUSHER_API_KEY, {authEndpoint: '/pusher/authentication', authTransport: 'ajax', activityTimeout: 120000, disableStats: true});
});
