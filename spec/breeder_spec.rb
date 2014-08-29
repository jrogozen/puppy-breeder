require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", "Pitbull", "Brown")}
	let(:lucky) {PuppyBreeder::Puppy.new("Lucky", "Golden Retriever", "Golden")}
	let(:puppylist) {PuppyBreeder::PuppyList.new}
	let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
	let(:purchase_request) {PuppyBreeder::PurchaseRequest.new(spot, jackson)}
	let(:purchase_request2) {PuppyBreeder::PurchaseRequest.new(lucky, jackson)}
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
			expect(jon.review_purchase_request(purchase_request_list, purchase_request.id).puppy.name).to eq("Spot")
		end
	end

	describe '#all_purchase_requests' do
		it "look at all purchase requests" do
			purchase_request_list.add(purchase_request)
			purchase_request_list.add(purchase_request2)

			# look at the second request
			expect(jon.all_purchase_requests(purchase_request_list)[purchase_request2.id].puppy.name).to eq("Lucky")
		end
	end

	describe '#update_purchase_request' do
		it "change status of purchase request to approved" do
			
		end

		it "change status of purchase request to denied" do
		end
	end

	describe "delete_purchase_request" do
		it "successfully removes a purchase request" do
		end
	end

	describe "complete_purchase_request" do
		it "should change status of a request to completed" do
		end
	end
end