def create_new_admin
	  user = User.new(

		  :name		=> 'Admin',
		  :pwhash 	=> '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
		  :mail		=> 'admin@provider.com',
	  )
    unless user.save
      user.errors.each do |e|
        puts e
      end
    end
end

  def create_public_room

	  room = Room.new(	

		  :name 		=> 'Public',
		  :user	=> User.first(:name => 'Admin'),
		  :users		=> User.all,
	    )
  unless room.save
    room.errors.each do |e|
      puts e 
    end
  end

    end

    def create_first_post

      post = Post.new(	

        :content	=> 'Hello World!',
        :user	=> User.first(:name => 'Admin'),
        :room	=> Room.first(:name => 'Public')

      )
    unless post.save
      post.errors.each do |e|
        pust e
      end
    end

    
    end
    
    def create_new_user

        hash = Digest::SHA256.hexdigest params[:PW]
        user = User.new(

          :name		=> params[:name],
          :pwhash 	=> hash,
          :mail		=> params[:mail],
          :rooms => Room.all(:name => 'Public')

        )
  unless user.save
        user.errors.each do |e|
          puts e
        end
      end

        redirect "/"

    end

    def create_new_post

      post = Post.new(	
      
        :content 	=> params[:content],
        :user_id	=> session[:user_id],
        :room_id	=> params[:room],
	  )
  unless post.save
      post.errors.each do |e|
        pust e
      end
    end

    end

  def create_new_room

    opener = User.get(session[:user_id])
    #binding.pry

	  room = Room.new(	
		  :name 		=> params[:room_name],
      :user	=> opener,
      :users => User.all(:name => ['Admin']) + User.all(:id => params[:users])
	  )
unless room.save
  room.errors.each do |e|
    puts e
  end 
end

    redirect '/'

  end
