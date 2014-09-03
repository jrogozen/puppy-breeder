require_relative 'repo.rb'

module PuppyBreeder
	module Repos
		class Puppies < Repo
			
			def create_table
				query = <<-SQL
					CREATE TABLE puppies (
						id SERIAL PRIMARY KEY,
						name TEXT,
						breed TEXT,
						age INTEGER,
						status TEXT
					);
				SQL
				@db_adapter.exec(query)
			end

			def add(puppy_obj)
				query = <<-SQL
					INSERT INTO puppies (name, breed, age, status)
					VALUES ('#{puppy_obj.name}', '#{puppy_obj.breed}', '#{puppy_obj.age}', 'available')
					returning id;
				SQL
				@db_adapter.exec(query)
			end

		end
	end
end