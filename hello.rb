require 'rubygems'
require 'sinatra'
require 'flickraw'

FlickRaw.api_key = '5b2227672a4f87feea2e6d08baf007fb'
FlickRaw.shared_secret = '3ca640f481a2bec9'
user_id = '62399885@N08'

# get '/auth' do
#   frob = flickr.auth.getFrob
#   auth_url = FlickRaw.auth_url :frob => frob, :perms => 'read'
# 
#   redirect auth_url
# 
#   begin
#     auth = flickr.auth.getToken :frob => frob
#     login = flickr.test.login
#     puts "You are now authenticated as #{login.username} with token #{auth.token}"
#   rescue FlickRaw::FailedResponse => e
#     puts "Authentication failed : #{e.msg}"
#   end
# end

get '/:tag' do
  @list = flickr.photos.search :user_id => user_id, :tags => "#{params[:tag]}"
  erb :tag
end

get '/:tag/:photo_id' do
  @photo = flickr.photos.getInfo(:photo_id => params[:photo_id])
  erb :photo
end

get '/' do
  @gravures = flickr.photos.search :user_id => user_id, :tags => "gravures", :per_page => "3", :extras => "url_s"  
  @sculptures = flickr.photos.search :user_id => user_id, :tags => "sculptures", :per_page => "3", :extras => "url_s"  
  @peintures = flickr.photos.search :user_id => user_id, :tags => "peintures", :per_page => "3", :extras => "url_s"  
  @dessins = flickr.photos.search :user_id => user_id, :tags => "dessins", :per_page => "3", :extras => "url_s"  
  erb :index
end
