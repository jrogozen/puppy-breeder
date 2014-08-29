#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_accessor :status
  	attr_reader :name, :breed, :color, :age, :price

  	def initialize(name, breed, color, age)
  		@name, @breed, @color, @age = name, breed, color, age
  		@status = "available"
  	end

  	def can_be_sold?
  		return false unless @status == "available"
  		true
  	end
  end
end