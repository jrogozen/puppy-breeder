require_relative 'puppies.rb'
require_relative 'purchases.rb'
require_relative 'waitlist.rb'

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

		def self.waitlist_repo=(x)
			@@waitlist_repo = x
		end

		def self.waitlist_repo
			@@waitlist_repo
		end

	module Repos
		def self.create_tables
			PuppyBreeder.puppies_repo.create_table
			PuppyBreeder.purchases_repo.create_table
			PuppyBreeder.waitlist_repo.create_table
		end

		def self.drop_tables
			query = <<-SQL
				DROP TABLE IF EXISTS puppies CASCADE;
				DROP TABLE IF EXISTS purchases CASCADE;
				DROP TABLE IF EXISTS waitlist CASCADE
			SQL
			db_adapter = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
			db_adapter.exec(query)
		end
	end
end