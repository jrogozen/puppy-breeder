#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_reader :name, :breed, :color

  	def initialize(name, breed, color)
  		@name, @breed, @color = name, breed, color
  		@status = "available"
  	end
  end
end