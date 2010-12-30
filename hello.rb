require 'rubygems'
require 'sinatra'
require 'flickraw'

FlickRaw.api_key = '5b2227672a4f87feea2e6d08baf007fb'
FlickRaw.shared_secret = '3ca640f481a2bec9'
user_id = '71266666@N00'

get '/auth' do
  frob = flickr.auth.getFrob
  auth_url = FlickRaw.auth_url :frob => frob, :perms => 'read'

  redirect auth_url

  begin
    auth = flickr.auth.getToken :frob => frob
    login = flickr.test.login
    puts "You are now authenticated as #{login.username} with token #{auth.token}"
  rescue FlickRaw::FailedResponse => e
    puts "Authentication failed : #{e.msg}"
  end
end

get '/:tag' do
  @list = flickr.photos.search :user_id => user_id, :tags => "#{params[:tag]}"
  erb :tag
end

get '/:tag/:photo_id' do
  @photo = flickr.photos.getInfo(:photo_id => params[:photo_id])
  erb :photo
end

get '/' do
  @gravures = flickr.photos.search :user_id => user_id, :tags => "argentique", :per_page => "3", :extras => "url_s"  
  @sculptures = flickr.photos.search :user_id => user_id, :tags => "iphone", :per_page => "3", :extras => "url_s"  
  @peintures = flickr.photos.search :user_id => user_id, :tags => "blackandwhite", :per_page => "3", :extras => "url_s"  
  erb :index
end