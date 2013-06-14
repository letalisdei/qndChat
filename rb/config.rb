def config

	configure do

		set :bind => '0.0.0.0'
		set :port => '1234'

	end


	#Datailierte Ausgabe in der Konsole aktivieren
	DataMapper::Logger.new($stdout, :debug)

	#In der Datenbank einloggen
	DataMapper.setup(:default, 'mysql://root:auf der reise@localhost/chat')

	#Session Settings einrichten
	use Rack::Session::Pool, :expire_after => 1000000
	set :session_secret, 'super secret'


	DataMapper.finalize
	DataMapper.auto_upgrade!

end
