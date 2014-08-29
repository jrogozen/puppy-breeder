module PuppyBreeder
	class PurchaseRequestList
		attr_reader :name, :purchase_requests

		def initialize(name=nil)
			@name = name
			@purchase_requests = {}
		end

		def add(purchase_request)
			@purchase_requests[purchase_request.id] = purchase_request
		end
	end
end