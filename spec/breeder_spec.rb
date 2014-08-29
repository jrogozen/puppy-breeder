require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", "Pitbull", "Brown")}
	let(:puppylist) {PuppyBreeder::PuppyList.new}


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
end