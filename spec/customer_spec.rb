require_relative 'spec_helper.rb'

describe PuppyBreeder::Customer do 
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbull, "Brown", 1)}
	let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
	let(:purchase_request_list) {PuppyBreeder::PurchaseRequestList.new}

	describe '#create_purchase_request' do
		it "successfully creates a purchase request" do
			jackson.create_purchase_request(purchase_request_list, spot, {:payment_method => "credit card"})
			expect(purchase_request_list.purchase_requests.length).to eq(1)
		end
	end
end