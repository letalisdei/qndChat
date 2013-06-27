class User

	include DataMapper::Resource

	property :id,			Serial
	property :name, 		Text, length: (5..20)
	property :pwhash,		Text, length: (64..64)
	property :lastlogin,		DateTime
	property :mail,			String, length: 254
	
	has n, :posts
	has n, :own_rooms, 'Room'
	has n, :rooms, :through => Resource

end

class Post

	include DataMapper::Resource

	property :id,			Serial
	property :content, 		Text
	property :created_at, DateTime
	property :updated_at, DateTime

	belongs_to :user
	belongs_to :room
	

end

class Room
	include DataMapper::Resource
	
	property :id,			Serial
	property :name,			Text, length: (2..100)
  property :created_at, DateTime
	belongs_to :user
	has n, :posts
	has n, :users, :through => Resource

		
end


