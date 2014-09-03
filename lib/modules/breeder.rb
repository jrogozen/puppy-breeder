module PuppyBreeder
	class Breeder
		attr_reader :name

		def initialize(name)
			@name = name
		end

		def add_puppy(puppy)
			PuppyBreeder.puppies_repo.add(puppy)
		end

		# look into making two methods. one to create purchase request and one to add it to a list
		def create_purchase_request(customer, breed)
			PuppyBreeder.purchases_repo.add(PurchaseRequest.new({:breed => breed, :customer => customer}))
		end

		def review_purchase_request(pr_id)
			result = PuppyBreeder.purchases_repo.view_by_id(pr_id)
			result.values
		end

		def all_purchase_requests(pr_list)
			pr_list.purchase_requests
		end

		def update_purchase_request(pr_list, pr_id, order_status)
			purchase = pr_list.purchase_requests[pr_id]
			purchase.order_status = order_status
		end

		def complete_purchase_request(purchase)
			purchase.order_status = "completed"
			purchase.breed.remove_from_waitlist(purchase.customer)
			return purchase
		end

		def hold_purchase_request(purchase)
			purchase.order_status = "hold"
			purchase.breed.add_to_waitlist(purchase.customer)
			return purchase
		end

		def process_purchase_request(pp_list, pr_list, pr_id)
			# this returns a puppy if we have one available
			# pup is an array with [0] = name, [1] = puppy object
			purchase = pr_list.purchase_requests[pr_id]

			if pp_list.match_puppy(purchase.breed)
				# gross
				if purchase.breed.wait_list.empty? || purchase.breed.wait_list.first == purchase.customer
					pup = pp_list.match_puppy(purchase.breed)[1]
					pup.status = "sold"
					complete_purchase_request(purchase)
				end
			else
				hold_purchase_request(purchase)
			end
		end

		def delete_purchase_request(pr_list, pr_id)
			pr_list.purchase_requests.delete(pr_id)
		end

		def view_completed_orders(pr_list)
			pr_list.purchase_requests.select do |purchase_id, purchase|
				purchase.order_status == "completed"
			end
		end

		def view_pending_orders(pr_list)
			pr_list.purchase_requests.select do |purchase_id, purchase|
				purchase.order_status == "pending"
			end
		end

		def view_hold_orders(pr_list)
			pr_list.purchase_requests.select do |purchase_id, purchase|
				purchase.order_status == "hold"
			end
		end

		def set_breed_price(breed, price)
			breed.price = price
		end
	end
end