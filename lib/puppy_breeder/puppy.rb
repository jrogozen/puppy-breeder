#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_accessor :status
  	attr_reader :name, :breed, :color

  	def initialize(name, breed, color)
  		@name, @breed, @color = name, breed, color
  	end
  end
end