module PuppyBreeder
	class Customer
		attr_reader :name

		def initialize(name)
			@name = name
		end

		def create_purchase_request(pr_list, puppy, opt={})
			pr_list.add(PurchaseRequest.new(puppy, self, opt))
		end
	end
end