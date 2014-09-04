module PuppyBreeder
	module Repos
	end
end

#db is 'puppy-breeder'
require_relative 'lib/puppy_breeder.rb'

PuppyBreeder.puppies_repo   = PuppyBreeder::Repos::Puppies.new
PuppyBreeder.purchases_repo = PuppyBreeder::Repos::Purchases.new
PuppyBreeder.waitlist_repo  = PuppyBreeder::Repos::Waitlist.new