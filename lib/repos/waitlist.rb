require_relative 'repo.rb'

module PuppyBreeder
	module Repos
		class Waitlist < Repo
			
			def create_table
				query = <<-SQL
					CREATE TABLE waitlist (
						id SERIAL PRIMARY KEY,
						customer TEXT,
						breed TEXT,
						status TEXT
					);
				SQL
				@db_adapter.exec(query)
			end

			def build_entity(row)
				PuppyBreeder::Waitlist.new({:breed => Breed.new(row[:breed]), :customer => Customer.new(row[:customer]), :status => row[:status]})
			end

			def add(customer, breed)
				query = <<-SQL
					INSERT INTO waitlist (customer, breed, status)
					VALUES ('#{customer.name}', '#{breed.name}', 'waiting')
					returning *;
				SQL
				result = clean_hash(@db_adapter.exec(query).first)
			end

			def update(customer, breed, status)
				query = <<-SQL
					UPDATE waitlist
					SET status = '#{status}'
					WHERE customer = '#{customer.name}' AND breed = '#{breed.name}'
					returning *;
				SQL
				result = clean_hash(@db_adapter.exec(query).first)
			end

			# only completed 
			def completed_waitlist(breed)
				query = <<-SQL
				SELECT * FROM waitlist
				WHERE breed = '#{breed.name}' AND status = 'completed'
				SQL
				result = @db_adapter.exec(query).entries

        result.entries.map do |row|
           data = clean_hash(row)
           build_entity(data)
        end
			end

			# only pending
			def show_waitlist(breed)
				query = <<-SQL
				SELECT * FROM waitlist
				WHERE breed = '#{breed.name}' AND status = 'waiting'
				SQL
				result = @db_adapter.exec(query).entries

        result.entries.map do |row|
           data = clean_hash(row)
           build_entity(data)
        end
			end

			def has_waitlist?(breed)
				@potential_waitlist = show_waitlist(breed)
				if @potential_waitlist.length > 0 
					return true
				end
				return nil
			end

		end
	end
end