#if Rails.env.development?
#  Pusher.app_id = '24310'
#  Pusher.key = 'e221bc3495c05b7df9dd'
#  Pusher.secret = 'f4faf47f16352976d518' 
#else
#Pusher.url = "https://ff2b4a750ed09094e2e9:f59ea339573408c7bf3d@api.pusherapp.com/apps/110597"
#Pusher.logger = Rails.logger
  Pusher.app_id = ENV['APP_ID']
  Pusher.key = ENV['PUSHER_API_KEY']
  Pusher.secret = ENV['PUSHER_SECRET']
#end 
#Pusher.host = '54.186.39.143'
#Pusher.port = 4567

