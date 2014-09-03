module PuppyBreeder
	class PurchaseRequestList
		attr_reader :name, :purchase_requests

		def initialize(name=nil)
			@name = name
			@id = 0
			@purchase_requests = Hash.new
		end

		def add(purchase_request)
			@id += 1
			purchase_request.id = @id
			@purchase_requests[purchase_request.id] = purchase_request
		end
	end
end