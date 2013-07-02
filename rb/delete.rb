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