module PuppyBreeder
	class Breed
		attr_accessor :price, :wait_list
		attr_reader :name
		
		def initialize(name, price = nil)
			@name, @price = name, price
		end
		
	end
end