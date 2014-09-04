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
					returning *;
				SQL
				result = clean_hash(@db_adapter.exec(query).first)
				pr_obj.instance_variable_set("@id", result[:id].to_i)
			end

			def build_entity(row)
				PurchaseRequest.new(:id => row[:id].to_i, :customer => Customer.new(row[:customer]), :breed => Breed.new(row[:breed]), :order_status => row[:order_status])
			end

			def update(pr_id, order_status)
				query = <<-SQL
					UPDATE purchases
					SET order_status = '#{order_status}'
					WHERE purchases.id = '#{pr_id}'
					returning *;
				SQL
				result = clean_hash(@db_adapter.exec(query).first)
			end

			def view_by_id(id)
				query = <<-SQL
					SELECT * FROM purchases where id = '#{id}'
				SQL
				result = clean_hash(@db_adapter.exec(query).first)
				
				build_entity(result)
			end

			def view_by_query(order_status)
				query = <<-SQL
					SELECT * FROM purchases where order_status = '#{order_status}'
				SQL
				result = @db_adapter.exec(query).entries

				result.entries.map do |row|
					data = clean_hash(row)
					build_entity(data)
				end
			end

			def view_all
				query = <<-SQL
					SELECT * FROM purchases 
				SQL
				result = @db_adapter.exec(query).entries

				result.entries.map do |row|
					data = clean_hash(row)
					build_entity(data)
				end
			end

		end
	end
end