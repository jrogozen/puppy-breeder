module PuppyBreeder
	class PuppyList
		attr_reader :puppies

		def initialize(name=nil)
			@name = name
			@puppies = {}
		end

		def add(puppy, status="available")
			@puppies[puppy.name.to_sym] = puppy
			@puppies[puppy.name.to_sym].status = status
		end

		def have_puppy?(breed)
			@suitable_puppies = @puppies.select do |puppy_name, puppy|
				puppy.breed == breed && puppy.status == "available"
			end

			if @suitable_puppies.length > 0
				return true
			end

			return false
		end

		def match_puppy(breed)
			if have_puppy?(breed)
				return @suitable_puppies.first
			else
				return nil
			end
		end

	end
end