require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequestList do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbull, "Brown", 100)}
	let(:puppylist) {PuppyBreeder::PuppyList.new}
	let(:purchase_request) {PuppyBreeder::PurchaseRequest.new(pitbull, {:request_type => "verbal"})}
	let(:purchase_request_list) {PuppyBreeder::PurchaseRequestList.new}

	describe '#add' do
		it "adds purchase requests to list" do
			purchase_request_list.add(purchase_request)
			expect(purchase_request_list.purchase_requests[purchase_request.id]).to eq(purchase_request)
		end
	end
end