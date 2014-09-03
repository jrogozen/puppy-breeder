require_relative 'puppy_list.rb'
require_relative 'purchase_request_list.rb'
require_relative 'puppies.rb'
require_relative 'purchases.rb'

module PuppyBreeder
	module Repos
		def self.create_tables
			PuppyBreeder.puppies_repo.create_table
			PuppyBreeder.purchases_repo.create_table
		end
	end
end