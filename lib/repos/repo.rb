require 'pg'
	
module PuppyBreeder
	module Repos
		class Repo
			def initialize
				@db_adapter = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
			end

			def clean_hash(hash) 
				Hash[hash.map{ |k, v| [k.to_sym, v] }]
			end
		end
	end
end