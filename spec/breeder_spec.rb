require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:golden_retriever) {PuppyBreeder::Breed.new("Golden Retriever", 100)}
	let(:poodle) {PuppyBreeder::Breed.new("Poodle", 40)}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbull, "Brown", 10)}
	let(:lucky) {PuppyBreeder::Puppy.new("Lucky", golden_retriever, "Golden", 21)}
	let(:sniffles) {PuppyBreeder::Puppy.new("Sniffles", poodle, "Black", 30)}
	let(:puppylist) {PuppyBreeder::PuppyList.new}
	let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
	let(:purchase_request) {PuppyBreeder::PurchaseRequest.new(pitbull, jackson)}
	let(:purchase_request2) {PuppyBreeder::PurchaseRequest.new(golden_retriever, jackson)}
	let(:purchase_request3) {PuppyBreeder::PurchaseRequest.new(poodle, jackson)}
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

	describe '#complete_purchase_request' do
		it "when order status is completed, should change puppy status to unavailable" do
			puppylist.add(spot)
			purchase_request_list.add(purchase_request)
			jon.complete_purchase_request(puppylist, purchase_request_list, purchase_request.id)
			expect(spot.status).to eq("sold")

		end

		it "can't sell puppy if it isn't available" do
			puppylist.add(sniffles)
			sniffles.status = "sold"
			purchase_request_list.add(purchase_request3)
			expect(jon.complete_purchase_request(puppylist, purchase_request_list, purchase_request3.id)).to be_nil
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