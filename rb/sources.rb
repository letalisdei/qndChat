

def create_new_admin

	user = User.new(

		:name		=> 'Admin',
		:pwhash 	=> '7ac0fe6dfc734566f26aaa6d027ba2dff254c9c0520c8ede121de4e038c5cc36',
		:lastlogin	=> Time.now,
		:mail		=> 'admin@provider.com'

	)

	user.save

end

def create_public_room

	users = User.last
	users.id

	room = Room.new(	

		:name 		=> 'public',
		:timestamp 	=> Time.now,
		:user_id	=> User.first(:name => 'Admin').id
=begin		:accesses	=>{
				:user_id => 1
			}
					
=end	
	)
	
	room.save

end

def create_first_post

	post = Post.new(	

		:content	=> 'Hello World!',
		:timestamp 	=> Time.now,
		:user_id	=> User.first(:name => 'Admin').id,
		:room_id	=> Room.first(:name => 'public').id

	)
	
	post.save

end

def go_to_public_room_logged_in

	public_room = Room.first(:name => 'public').id
	redirect "/room/#{public_room}"	

end

def go_to_public_room_logged_out

	@users = User.all 
	@posts = Post.all(	:limit => 5,:order => [ :timestamp.desc ],
				:room_id => Room.first(:name => 'public').id)
	erb :anmelden	

end

def logged_in

		@user.update(:lastlogin => Time.now)			

		session[:value] = 'true'
		session[:user_id] = @user.id
		erb :anm_erf

end

def loggin_out

	session.clear
	erb :abgemeldet

end

def create_new_user

	user = User.new(

		:name		=> params[:name],
		:pwhash 	=> params[:PW],
		:lastlogin	=> Time.now,
		:mail		=> params[:mail]

	)

	user.save

	redirect "/"

end

def create_new_post

	post = Post.create(	
	
	:content 	=> params[:content],
	:timestamp 	=> Time.now,
	:user_id	=> session[:user_id],
	:room_id	=> params[:room],
	)
	redirect "/room"
end

def create_new_room

	room = Room.create(	

		:name 		=> params[:room_name],
		:timestamp 	=> Time.now,
		:user_id	=> session[:user_id],
	)

end

def go_to_textfenster

	@users = User.all 
	@user_id =  session[:user_id]
	@room_id = params[:room_id]
	@posts = Post.all(:limit => 5,:order => [ :timestamp.desc ],:room_id => @room_id) 
	@rooms = Room.all
	erb :textfenster

end

def go_to_admin

	@user = User.all 
	erb:admin

end

def go_to_rooms

	@room = Room.all
	erb :rooms

end

def go_to_posts

	@users = User.all 
	@posts = Post.all 
	@rooms = Room.all

	erb :posts

end

def go_to_accesses

	@accesses = Access.all

	erb :accesses

end

def delete_user

	User.get(params[:id]).destroy
	erb:user_deleted

end

def delete_post

	Post.get(params[:id]).destroy
	erb:post_deleted

end

def delete_room

	Room.get(params[:id]).destroy
	erb:room_deleted

end
