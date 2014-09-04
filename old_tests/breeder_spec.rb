require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:golden_retriever) {PuppyBreeder::Breed.new("Golden Retriever", 100)}
	let(:poodle) {PuppyBreeder::Breed.new("Poodle", 40)}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new({:name => "Spot", :breed => pitbull, :age => 10})}
	let(:lucky) {PuppyBreeder::Puppy.new("Lucky", golden_retriever, "Golden", 21)}
	let(:sniffles) {PuppyBreeder::Puppy.new("Sniffles", poodle, "Black", 30)}
	let(:puppylist) {PuppyBreeder::PuppyList.new}
	let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
	let(:usher) {PuppyBreeder::Customer.new("Usher")}
	let(:purchase_request) {PuppyBreeder::PurchaseRequest.new(pitbull, jackson)}
	let(:purchase_request2) {PuppyBreeder::PurchaseRequest.new(golden_retriever, jackson)}
	let(:purchase_request3) {PuppyBreeder::PurchaseRequest.new(poodle, jackson)}
	let(:purchase_request4) {PuppyBreeder::PurchaseRequest.new(pitbull, usher)}
	let(:purchase_request_list) {PuppyBreeder::PurchaseRequestList.new}
	let(:create_one) {jon.create_purchase_request(purchase_request_list, jackson, spot, {:request_type => "letter"})}
	
	describe '#initialize' do 
		it "initializes instance of Breeder class" do
			expect(jon).to be_kind_of(PuppyBreeder::Breeder)
		end
	end

	describe '#add_puppy' do
		it "should add puppy to PuppyList" do
			jon.add_puppy(puppylist, spot, "available")
			expect(puppylist.puppies[:Spot].name).to eq("Spot")
		end
	end

	describe '#create_purchase_request' do
		it "add new purchase request to list" do
			jon.create_purchase_request(purchase_request_list, jackson, spot, {:request_type => "letter"})
			# verify length
			expect(purchase_request_list.purchase_requests.length).to eq(1)
		end
	end

	describe '#review_purchase_request' do
		# should be able to look at purchase request by ID
		it "look at one purchase request" do
			purchase_request_list.add(purchase_request)
			expect(jon.review_purchase_request(purchase_request_list, purchase_request.id).breed.name).to eq("Pitbull")
		end
	end

	describe '#all_purchase_requests' do
		it "look at all purchase requests" do
			purchase_request_list.add(purchase_request)
			purchase_request_list.add(purchase_request2)

			# look at the second request
			expect(jon.all_purchase_requests(purchase_request_list)[purchase_request2.id].breed.name).to eq("Golden Retriever")
		end
	end

	describe '#update_purchase_request' do
		it "change status of purchase request to approved" do
			purchase_request_list.add(purchase_request)

			# change the status to approved
			jon.update_purchase_request(purchase_request_list, purchase_request.id, "approved")
			expect(purchase_request.order_status).to eq("approved")
		end

		it "change status of purchase request to denied" do
			purchase_request_list.add(purchase_request)
			jon.update_purchase_request(purchase_request_list, purchase_request.id, "denied")
			expect(purchase_request.order_status).to eq("denied")
		end
	end

	describe '#process_purchase_request' do 
		it "completes a purchase request" do
			puppylist.add(spot)
			purchase_request_list.add(purchase_request)
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)

			# process works
			expect(spot.status).to eq("sold")

			# complete works
			expect(purchase_request.order_status).to eq("completed")
		end

		it "puts a request on hold" do
			puppylist.add(spot)

			# set no available puppy
			spot.status = "sold"
			purchase_request_list.add(purchase_request)

			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			expect(purchase_request.order_status).to eq("hold")
		end

		it "put a request on hold and then accepts it next time" do
			puppylist.add(spot)

			# set no available pup
			spot.status = "sold"
			purchase_request_list.add(purchase_request)
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			expect(purchase_request.order_status).to eq("hold")

			# set available pup
			puppylist.add(PuppyBreeder::Puppy.new("Woof", pitbull, "Black", 1))
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			expect(purchase_request.order_status).to eq("completed")
		end

		it "adds customer to waitlist" do
			puppylist.add(spot)

			# set no available puppy
			spot.status = "sold"
			purchase_request_list.add(purchase_request)

			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			expect(pitbull.wait_list[0]).to eq(jackson)
		end

		it "doesnt accept someone who isn't first on the waitlist" do
			puppylist.add(spot)

			# set no available pup
			spot.status = "sold"
			purchase_request_list.add(purchase_request)
			purchase_request_list.add(purchase_request4)
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request4.id)
			spot.status = "available"
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request4.id)
			expect(purchase_request4.order_status).to eq("hold")
		end

		it "accepts someone first on the waitlist" do
			puppylist.add(spot)

			# set no available pup
			spot.status = "sold"
			purchase_request_list.add(purchase_request)
			purchase_request_list.add(purchase_request4)
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request4.id)
			spot.status = "available"
			jon.process_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			expect(purchase_request.order_status).to eq("completed")
		end

	end

	describe "#delete_purchase_request" do
		it "successfully removes a purchase request" do
			purchase_request_list.add(purchase_request)
			jon.delete_purchase_request(purchase_request_list, purchase_request.id)
			expect(purchase_request_list.purchase_requests[purchase_request.id]).to be_nil
		end
	end

	describe '#view_completed_orders' do
		it "should list out all completed orders only" do
			purchase_request_list.add(purchase_request)
			purchase_request_list.add(purchase_request2)

			jon.update_purchase_request(purchase_request_list, purchase_request.id, "completed")
			expect(jon.view_completed_orders(purchase_request_list)[purchase_request.id].breed.name).to eq("Pitbull")
		end
	end

	describe "#view_pending_orders" do
		it "should list out all completed orders only" do
			purchase_request_list.add(purchase_request)
			purchase_request_list.add(purchase_request2)

			jon.update_purchase_request(purchase_request_list, purchase_request2.id, "approved")
			expect(jon.view_pending_orders(purchase_request_list)[purchase_request.id].breed.name).to eq("Pitbull")
		end
	end

	describe '#set_breed_price' do
		it "should update a breed's price" do
			jon.set_breed_price(pitbull, 10)
			expect(pitbull.price).to eq(10)
		end
	end
end