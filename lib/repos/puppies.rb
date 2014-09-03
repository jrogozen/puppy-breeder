module PuppyBreeder
	module Repos
		class Puppies < Repo
			
			def create_table
				command = <<-SQL
					CREATE TABLE puppies (
						id SERIAL PRIMARY KEY
						name TEXT,
						breed TEXT,
						color TEXT,
						age INTEGER,
						status TEXT,
					);
				SQL
			end
			
		end
	end
end