class User

	include DataMapper::Resource

	property :id,			Serial
	property :name, 		Text
	property :pwhash,		Text
	property :lastlogin,	DateTime
	property :mail,			String

	has n, :posts
	has n, :rooms
	has n, :accesses
	has n, :rooms, :through => :accesses

end

class Post

	include DataMapper::Resource

	property :id,			Serial
	property :content, 		Text
	property :timestamp,	DateTime

	belongs_to :user
	belongs_to :room
	

end

class Room
	include DataMapper::Resource
	
	property :id,			Serial
	property :name,			Text
	property :timestamp,	DateTime

	belongs_to :user
	has n, :posts
	has n, :accesses
	has n, :users, :through => :accesses
		
end

class Access

	include DataMapper::Resource	

	property :id,			Serial

	belongs_to :user
	belongs_to :room

end
