module PuppyBreeder
	module Repos
	end
end

#db is 'puppy-breeder'
require_relative 'lib/puppy_breeder.rb'

# for testing in irb 
jon = PuppyBreeder::Breeder.new("Jon")


PuppyBreeder.puppies_repo = PuppyBreeder::Repos::Puppies.new
PuppyBreeder.purchases_repo = PuppyBreeder::Repos::Purchases.new