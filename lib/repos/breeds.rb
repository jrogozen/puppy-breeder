require_relative 'repo.rb'

module PuppyBreeder
  module Repos
    class Breeds < Repo

      def create_table
        query = <<-SQL
            CREATE TABLE breeds (
            id SERIAL PRIMARY KEY,
            name TEXT,
            price INTEGER
          );
        SQL
        @db_adapter.exec(query)
      end

      def add(name, price)
        query = <<-SQL
          INSERT INTO breeds (name, price)
          VALUES ('#{name}', '#{price}')
          returning *;
        SQL
        result = clean_hash(@db_adapter.exec(query).first)
        build_entity(result)
      end

      def build_entity(data)
        Breed.new({:name => data[:name], :price => data[:price]})
      end

      def show_breed(name)
        query = <<-SQL
          SELECT * FROM breeds
          WHERE name = '#{name}'
        SQL
        result = @db_adapter.exec(query).entries
        result.map do |row|
          data = clean_hash(row)
          build_entity(data)
        end
      end

      def check_for_dup(name)
        if show_breed(name).length >= 1
          return true
        else
          false
        end
      end

    end
  end
end