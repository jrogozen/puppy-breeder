module PuppyBreeder
	module Repos
		class Repo
			def initialize
				@db_adapter = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
			end
		end
	end
end