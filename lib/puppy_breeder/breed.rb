module PuppyBreeder
	class Breed
		attr_accessor :price
		attr_reader :name
		
		def initialize(name, price = nil)
			@name, @price = name, price
		end
	end
end