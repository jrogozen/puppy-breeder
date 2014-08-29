require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbull, "Brown", 1)}
	let(:puppylist) {PuppyBreeder::PuppyList.new}
	let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
	let(:purchase_request) {PuppyBreeder::PurchaseRequest.new(spot, jackson, {:request_type => "verbal"})}

	describe '#initialize' do
		it "instantiates the purchase request class" do
			expect(purchase_request).to be_kind_of(PuppyBreeder::PurchaseRequest)
		end

		it "properly sets optional variables" do
			expect(purchase_request.request_type).to eq("verbal")
			expect(purchase_request.payment_method).to be_nil
		end

		it "properly attaches customer to purchase request" do
			expect(purchase_request.customer.name).to eq("Michael Jackson")
		end
	end

end