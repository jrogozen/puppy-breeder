require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", "Pitbull", "Brown")}
	let(:puppylist) {PuppyBreeder::PuppyList.new}
	let(:purchase_request) {PuppyBreeder::PurchaseRequest.new(spot, {:request_type => "verbal"})}

	describe '#initialize' do
		it "instantiates the purchase request class" do
			expect(purchase_request).to be_kind_of(PuppyBreeder::PurchaseRequest)
		end

		it "properly sets optional variables" do
			expect(purchase_request.request_type).to eq("verbal")
			expect(purchase_request.payment_method).to be_nil
		end
	end

end