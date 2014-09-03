require_relative 'puppy_list.rb'
require_relative 'purchase_request_list.rb'
require_relative 'puppies.rb'
require_relative 'purchases.rb'

module PuppyBreeder

		def self.puppies_repo=(x)
			@@puppies_repo = x
		end

		def self.puppies_repo
			@@puppies_repo
		end

		def self.purchases_repo=(x)
			@@purchases_repo = x
		end

		def self.purchases_repo
			@@purchases_repo
		end

	module Repos
		def self.create_tables
			PuppyBreeder.puppies_repo.create_table
			PuppyBreeder.purchases_repo.create_table
		end

		def self.drop_tables
			query = <<-SQL
				DROP TABLE IF EXISTS puppies CASCADE
				DROP TABLE IF EXISTS purchases CASCADE
			SQL
			db_adapter = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
			db_adapter.exec(query)
		end
	end
end