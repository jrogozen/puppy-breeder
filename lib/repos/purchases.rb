require_relative 'repo.rb'

module PuppyBreeder
	module Repos
		class Purchases < Repo
			
			def create_table
				query = <<-SQL
					CREATE TABLE purchases (
						id SERIAL PRIMARY KEY,
						customer TEXT,
						breed TEXT,
						order_status TEXT
					);
				SQL
				@db_adapter.exec(query)
			end

			def add(pr_obj)
				query = <<-SQL
					INSERT INTO purchases (customer, breed, order_status)
					VALUES ('#{pr_obj.customer.name}', '#{pr_obj.breed.name}', 'pending')
					returning id;
				SQL
				@db_adapter.exec(query)
			end

			def view_by_id(id)
				query = <<-SQL
					SELECT * FROM purchases where id = '#{id}'
				SQL
				@db_adapter.exec(query)
			end

		end
	end
end