#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_accessor :status
  	attr_reader :name, :breed, :age, :price, :id

  	def initialize(opt={})
  		@name = opt[:name]
  		@breed = opt[:breed]
  		@age = opt[:age]
  		@status = opt[:status] || 'available'
      @id = opt[:id]
  	end
  end
end