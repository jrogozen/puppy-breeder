module PuppyBreeder
	class Customer
		attr_reader :name

		def initialize(name)
			@name = name
		end

		def create_purchase_request(breed)
			new_pr = PurchaseRequest.new({:breed => breed, :customer => self})
      result = PuppyBreeder.purchases_repo.add(new_pr)
      return new_pr
		end
	end
end