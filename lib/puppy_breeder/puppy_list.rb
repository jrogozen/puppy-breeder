module PuppyBreeder
	class PuppyList
		attr_reader :puppies

		def initialize(name=nil)
			@name = name
			@puppies = {}

			# {
			# 	:puppy_name => {
			# 		:name => "joe"
			# 	}
			# }
		end

		def add(puppy, status=nil)
			@puppies[puppy.name.to_sym] = puppy
			@puppies[puppy.name.to_sym].status = status
		end

	end
end