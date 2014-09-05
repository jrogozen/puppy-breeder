module PuppyBreeder
	class Breed
		attr_accessor :price
		attr_reader :name
		
		def initialize(opt={})
			@name = opt[:name]
      @price = opt[:price]
		end
		
	end
end