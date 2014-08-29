require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", "Pitbull", "Brown")}
	let(:puppies) {PuppyBreeder::PuppyList.new}


	describe '#initialize' do 
		it "initializes instance of Breeder class" do
			expect(jon).to be_kind_of(PuppyBreeder::Breeder)
		end
	end

	describe '#add_puppy' do
		it "should add puppy to PuppyList" do
			# true sets puppy as available
			jon.add_puppy(puppies, spot, "available")
			expect(puppies.all_puppies.first.name).to eq("Spot")
		end
	end
end