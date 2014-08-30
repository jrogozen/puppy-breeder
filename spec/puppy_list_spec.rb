require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyList do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:golden_retriever) {PuppyBreeder::Breed.new("Golden Retriever", 100)}
	let(:lucky) {PuppyBreeder::Puppy.new("Lucky", golden_retriever, "Golden", 21)}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbull, "Brown", 10)}
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

	describe '#have_puppy?' do
		it "match 1 puppy" do
			puppylist.add(spot)
			puppylist.add(lucky)
			expect(puppylist.have_puppy?(pitbull)).to eq(true)
		end

		it "return nil for no puppies found" do
			puppylist.add(lucky)
			expect(puppylist.have_puppy?(pitbull)).to eq(false)
		end
	end

	describe '#match_puppy' do
		it "finds a suitable puppy and returns in" do
			puppylist.add(spot)
			expect(puppylist.match_puppy(pitbull).last).to eq(spot)
		end

		it "returns nil when it can't find find a puppy" do
			puppylist.add(spot)
			expect(puppylist.match_puppy(golden_retriever)).to be_nil
		end
	end
end