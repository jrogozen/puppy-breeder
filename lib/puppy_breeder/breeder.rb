module PuppyBreeder
	class Breeder
		attr_reader :name

		def initialize(name)
			@name = name
		end

		def add_puppy(puppy_list, puppy, status)
			puppy_list.add(puppy, status)
		end

		def create_purchase_request(pr_list, customer, puppy, opt={})
			pr_list.add(PurchaseRequest.new(puppy, customer, opt))
		end

		def review_purchase_request(pr_list, pr_id)
			pr_list.purchase_requests[pr_id]
		end

		def all_purchase_requests(pr_list)
			pr_list.purchase_requests
		end

	end
end