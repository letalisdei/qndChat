require 'sinatra'
require 'data_mapper'
require 'dm-core'
require 'dm-migrations'
require 'dm-aggregates' 
require './rb/mysqlbuild'
require './rb/sources'
require './rb/config'
require 'json'

config

get '/' do
	if User.count == 0
		create_new_admin
	end

	if Room.count == 0
		create_public_room
	end

	if Post.count == 0
		create_first_post
	end

	if  session[:value] == 'true'
		go_to_public_room_logged_in
	else	
		go_to_public_room_logged_out	
	end 
end


post '/log_in' do
	if @user = User.last(:name => params[:name])
		if @user.pwhash == params[:PW]			
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

	go_to_accesses

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
	File.read(File.join('css',params[:splat].first.to_s + '.css'))
end


get '/*.js' do	
 	File.read(File.join('js',params[:splat].first.to_s + '.js'))	
end



get '/test' do	
	erb :test
end

get '/test2' do	
	erb :test2
end

get '/post' do
  content_type :json
  #if params[:q] == 'newposts' 
  room = params[:room]
  #buffer = repository(:default).adapter.select('SELECT posts.id, content, users.name FROM posts INNER JOIN users ON users.id = posts.user_id;')
  Post.all(:room_id => room).to_json
  
end

get '/header' do
  
    content_type :json
    user = session[:user_id]
    User.get(user).to_json
    
end

get '/tabs' do
  
  content_type :json
  Room.all(:fields => [:id, :name]).to_json
end