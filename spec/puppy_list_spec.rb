require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyList do
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", "Pitbull", "Brown")}
	let(:puppylist) {PuppyBreeder::PuppyList.new}

	describe '#initialize' do
		it "initializes instance of PuppyList class" do
			expect(puppylist).to be_kind_of(PuppyBreeder::PuppyList)
		end
	end

	describe "#add" do
		it "correctly adds to puppies hash" do
			puppylist.add(spot, "available")
			expect(puppylist.puppies.key(spot)). to eq(:Spot)
		end

		it "correctly changes status to available" do
			puppylist.add(spot, "available")
			expect(puppylist.puppies[:Spot].status).to eq("available")
		end

		it "correctly changes status to unavailable" do
			puppylist.add(spot, "unavailable")
			expect(puppylist.puppies[:Spot].status).to eq("unavailable")
		end

	end
end