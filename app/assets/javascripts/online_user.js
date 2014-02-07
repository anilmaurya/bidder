window.online_users = {}

window.update_users_list = function(user){
  console.log(user.id)
  online_users[user.id] = {name: user.info.name}
     
  console.debug(online_users)
}

window.remove_user_from_list = function(user){
  delete online_users[user.id]  
}

update_select_box = function(all_users){
  if($('.online_user_select').length != 0)
  {
    $('.online_user_select').empty();
    Object.keys(all_users).forEach(function(key) {
      //build_option = '<option value=' + key + '>' + all_users[key] '</option>';
      if(key != $('#current_user_id').val())
      {
        console.debug('Adding username');
        console.debug(typeof(key));
        console.debug(typeof($('#current_user_id').val()));
        $('.online_user_select').append('<option value=' + key + '>' + all_users[key]['name'] + '</option>');
      }
    })
  } 
}


$(document).ready(function(){
  var is_user_present = $('#current_user').val()
  window.pusher = new Pusher(PUSHER_API_KEY, {authEndpoint: '/pusher/authentication', authTransport: 'ajax'});
  window.login_user_channel = pusher.subscribe('presence-user');
  login_user_channel.bind('pusher:subscription_succeeded', function(members) {
    console.debug(members.me.info.name);
    members.each(function(member){
      console.log("adding member");
      update_users_list(member)
    })
    update_select_box(online_users);
    console.log(online_users)
    login_user_channel.trigger('client-changeselectbox', {text: 'select'}) 
  });


  login_user_channel.bind('pusher:member_added', function(member) {
    update_users_list(member);
    login_user_channel.trigger('client-changeselectbox', {text: 'select'}); 
    
     
    update_select_box(online_users);
    console.log('predefined member add event')
  });


  login_user_channel.bind('pusher:subscription_error', function(status){
    //alert('aaaaaaaaaaaa');
    //update_users_list(user)
    console.log(status);
    
  });

  login_user_channel.bind('pusher:member_removed', function(member){
    remove_user_from_list(member);
    update_select_box(online_users);
    login_user_channel.trigger('client-changeselectbox', {text: 'select'}) 
  });

  login_user_channel.bind('client-changeselectbox', function(data){
    update_select_box(online_users);
  });


})
