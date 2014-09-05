require_relative 'repo.rb'

module PuppyBreeder
	module Repos
		class Puppies < Repo
			
			def create_table
				query = <<-SQL
					CREATE TABLE puppies (
						id SERIAL PRIMARY KEY,
						name TEXT,
						breed INTEGER REFERENCES breeds (id),
						age INTEGER,
						status TEXT
					);
				SQL
				@db_adapter.exec(query)
			end

			def add(puppy_obj)
        query = <<-SQL
          SELECT * FROM breeds 
          WHERE name = '#{puppy_obj.breed.name}'
        SQL

        breed_id = clean_hash(@db_adapter.exec(query).first)[:id].to_i

				query = <<-SQL
					INSERT INTO puppies (name, breed, age, status)
					VALUES ('#{puppy_obj.name}', '#{breed_id}', '#{puppy_obj.age}', 'available')
					returning id;
				SQL

				result = clean_hash(@db_adapter.exec(query).first)
        puppy_obj.instance_variable_set("@id", result[:id].to_i)
				result[:id].to_i
			end

      def build_entity(row)
        Puppy.new({:id => row[:id], :name => row[:name], :breed => Breed.new({:breed => row[:breed]}), :age => row[:age], :status => row[:status]})
      end

      def update(puppy_obj, status)
        query = <<-SQL
          UPDATE puppies
          SET status = '#{status}'
          WHERE puppies.id = '#{puppy_obj.id}'
          returning *;
        SQL

        result = clean_hash(@db_adapter.exec(query).first)
      end

      def select_puppy(breed)
        query = <<-SQL
          SELECT * FROM breeds
          WHERE name = '#{breed.name}'
        SQL
        
        result = @db_adapter.exec(query).entries

        if !result.nil? && result.length > 0
          breed_id = clean_hash(@db_adapter.exec(query).first)[:id].to_i
          
          query = <<-SQL
            SELECT * FROM puppies
            WHERE breed = '#{breed_id}' AND status = 'available'
          SQL
          result = @db_adapter.exec(query).entries

          if !result.nil? && result.length > 0
            return result.map do |row|
               data = clean_hash(row)
               build_entity(data)
            end
          end
        end
        result
      end

      def has_puppy?(breed)
        @suitable_puppies = select_puppy(breed)
        if @suitable_puppies.length > 0
          return true
        end
        return nil
      end

      def match_puppy(breed)
        if has_puppy?(breed)
         return @suitable_puppies.first
        end
        return nil
      end

      def view_puppies
        query = <<-SQL
        SELECT * FROM puppies
        SQL
        result = @db_adapter.exec(query).entries

        result.map do |row|
           data = clean_hash(row)
           build_entity(data)
        end
      end
		end
	end
end