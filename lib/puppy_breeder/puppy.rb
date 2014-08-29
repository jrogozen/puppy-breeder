#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_accessor :status
  	attr_reader :name, :breed, :color

  	def initialize(name, breed, color)
  		@name, @breed, @color = name, breed, color
  		@status = "available"
  	end

  	def can_be_sold?
  		return false unless @status == "available"
  		true
  	end
  end
end