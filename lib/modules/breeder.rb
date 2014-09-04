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
			new_pr = PurchaseRequest.new({:breed => breed, :customer => customer})
			result = PuppyBreeder.purchases_repo.add(new_pr)
			return new_pr
		end

		def review_purchase_request(pr_id)
			PuppyBreeder.purchases_repo.view_by_id(pr_id)
			
		end

		def all_purchase_requests
			PuppyBreeder.purchases_repo.view_all
		end

		def update_purchase_request(pr_id, order_status)
			PuppyBreeder.purchases_repo.update(pr_id, order_status)
		end

		def add_to_waitlist(customer, breed)
			PuppyBreeder.waitlist_repo.add(customer, breed)
		end

		def update_waitlist_status(customer, breed, status)
			PuppyBreeder.waitlist_repo.update(customer, breed, status)
		end

		def complete_purchase_request(pr_id)
			update_purchase_request(pr_id, 'completed')
		end

		def hold_purchase_request(pr_id)
			# get dat purchase request object
			pr = review_purchase_request(pr_id)

			update_purchase_request(pr.id, 'hold')
			add_to_waitlist(pr.customer, pr.breed)
		end

		# gross
		def process_purchase_request(pr_id)
			pr = review_purchase_request(pr_id)
			puppy = PuppyBreeder.puppies_repo.match_puppy(pr.breed)
			waitlist = PuppyBreeder.waitlist_repo.has_waitlist?(pr.breed)
			if !puppy.nil?
				#check waitlist repo to see if waitlist is empty or first entry matches
				if (!waitlist) || PuppyBreeder.waitlist_repo.show_waitlist(pr.breed)[0].customer.name == pr.customer.name
					if waitlist
						# update waitlist status
						PuppyBreeder.waitlist_repo.update(pr.customer, pr.breed, 'completed')
					end
					# change puppy status
					PuppyBreeder.puppies_repo.update(puppy, 'sold')
					# complete order request
					complete_purchase_request(pr.id)
				end
			else
				# add person to waitlist
				PuppyBreeder.waitlist_repo.add(pr.customer, pr.breed)
				# change purchase order to hold
				hold_purchase_request(pr.id)
			end
		end

		def delete_purchase_request(pr_id)
			update_purchase_request(pr_id, 'completed')
		end

		def view_select_orders(query)
			PuppyBreeder.purchases_repo.view_by_query(query)
		end

		def set_breed_price(breed, price)
			breed.price = price
		end
	end
end