require 'bundler'
Bundler.require :default

require './rb/mysqlbuild'
require './rb/create'
require './rb/direct'
require './rb/delete'
require './rb/config'

config

if User.count == 0
  puts 'Create new Admin!'
  create_new_admin
end

if Room.count == 0
  puts 'Create public room!'
  create_public_room
end

if Post.count == 0
    puts 'Create first Post!'
    create_first_post
  end


  get '/' do
    #binding.pry	

    if  session[:value] == 'true'
      go_to_public_room_logged_in
    else	
      go_to_public_room_logged_out	
    end 
  end


  post '/log_in' do
    if @user = User.last(:name => params[:name])
      hash = Digest::SHA256.hexdigest params[:PW]
      if @user.pwhash == hash			
        logged_in
      else
        erb :wrong_pw
      end
    else
      erb :no_user
    end
  end


  get '/log_out' do 
    loggin_out
  end


  get '/reg' do
    erb :reg
  end


  post '/registrieren' do
    if User.last(:name => params[:name])
      "Name schon vergeben"
    elsif User.last(:mail => params[:mail])
      "E-Mail Adresse schon vergeben"
    else
      create_new_user
    end
  end


  post '/posten' do
    create_new_post
  end


  get '/new_room' do
    erb :new_room
  end


  post '/create_room' do
    create_new_room
  end


  get '/admin' do
    go_to_admin
  end


  get '/rooms' do 
    go_to_rooms
  end


  get '/posts' do
    go_to_posts
  end

  get '/accesses' do

  end

  get '/room' do
    if session[:user_id]

      @rooms = Room.all
      erb :angemeldet
    else
      erb :no_room		
    end
  end


  get '/delete_user/:id' do
    delete_user	
  end

  get '/delete_post/:id' do
    delete_post	
  end

  get '/delete_room/:id' do
    delete_room	
  end

  get '/textfenster/:room_id' do

    if session[:user_id] and Room.get(params[:room_id])
      go_to_textfenster
    else
      erb :no_room		
    end

  end


  get '/*.css' do
    content_type 'text/css'
    File.read(File.join('css',params[:splat].first.to_s + '.css'))
  end


  get '/*.js' do
    content_type 'text/javascript'  
    File.read(File.join('js',params[:splat].first.to_s + '.js'))	
  end

  get '/post' do

    user = session[:user_id]
    room = params[:room]

    if User.get(user).rooms.get(room)

      #binding.pry
      content_type :json
      #if params[:q] == 'newposts' 
      Post.all(:room_id => room).to_json
    end
  end

get '/header' do

  content_type :json
  user = session[:user_id]
  User.get(user).to_json

end

get '/tabs' do

  #binding.pry

  content_type :json
  user_id = session[:user_id]
  user = User.get(user_id)
  room = user.rooms
  room.to_json


  #Room.all().to_json
end

get '/get_users' do

  content_type :json
  user_id = session[:user_id]
  users = User.all(:fields => ['id', 'name'])
  users.to_json

end



get '/weise' do

  p Room.all.to_json
  room = Room.new(	

                  :name 		=> 'NochnRaum',
                  :user	=> User.first(:name => 'Admin'),
                  :users		=> User.all,

                 )
                 p room.valid?
                 p room.errors.full_messages
                 room.save
                 "hallo"
                 p Room.all.to_json	
end
