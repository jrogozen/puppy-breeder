module PuppyBreeder
end

#db is 'puppy-breeder'
require_relative 'lib/puppy_breeder.rb'

PuppyBreeder.puppies_repo = PuppyBreeder::Repos::Puppies.new
PuppyBreeder.purchases_repo = PuppyBreeder::Repos::Purchases.new