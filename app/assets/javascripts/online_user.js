window.PUSHER_API_KEY = "4e751996cc1c32a5a4bb"
window.online_users = {}
window.update_users_list = function(user){
  window.online_users[user.id] = user   

}

window.remove_user_from_list = function(user){
   

}
$(document).ready(function(){
  if($('#current_user_id').val()){
    var is_user_present = $('#current_user')
    pusher = new Pusher(PUSHER_API_KEY, {authEndpoint: '/pusher/authentication', authTransport: 'ajax'});
    login_user_channel = pusher.subscribe('presence-user');
    login_user_channel.bind('pusher:subscription_succeeded', function(members) {
      console.debug(members.me.info.name);
      update_users_list(user)
      //var triggered = Pusher
      //var triggered = login_user_channel.trigger('client-added_to_list', {user_id: members.me.id, username: members.me.info.name})
      //var userId = me.user_id;
      //var userInfo = me.user_info.username;
      //alert('login');
    });

    login_user_channel.bind('pusher:member_added', function(member) {
      alert('predefined event')
    });


    login_user_channel.bind('pusher:subscription_error', function(status){
      update_users_list(user)
      console.log(status);
    });

    login_user_channel.bind('pusher:member_removed', function(member){
      remove_user_from_list(member.user_id)   
    });
  }
})
