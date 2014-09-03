module PuppyBreeder
	class Breed
		attr_accessor :price, :wait_list
		attr_reader :name
		
		def initialize(name, price = nil)
			@name, @price = name, price
			@wait_list = []
		end

		def add_to_waitlist(customer)
			@wait_list << customer
		end

		def remove_from_waitlist(customer)
			@wait_list.delete(customer)
		end
	end
end