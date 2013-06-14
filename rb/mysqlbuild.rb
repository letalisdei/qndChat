class User

	include DataMapper::Resource

	property :id,			Serial
	property :name, 		Text, length: (3..20)
	property :pwhash,		Text, length: (64..64)
	property :lastlogin,	DateTime
	property :mail,			String, length: 255

	has n, :posts
	has n, :rooms

	has n, :rooms, :through => Resource

end

class Post

	include DataMapper::Resource

	property :id,			Serial
	property :content, 		Text
	property :timestamp,	DateTime

property :created_at, DateTime
property :updated_at, DateTime

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
	#has n, :accesses
	has n, :users, :through => Resource

		
end

#class Access##

#	include DataMapper::Resource	

#	property :id,			Serial

#	belongs_to :user
#	belongs_to :room
#
#end
