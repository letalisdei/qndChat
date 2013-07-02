def go_to_public_room_logged_in

	  redirect "/room"	

  end

  def go_to_public_room_logged_out
    
	  @users = User.all 
	  @posts = Post.all(:room_id => Room.first(:name => 'Public').id)
	  erb :anmelden	

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
