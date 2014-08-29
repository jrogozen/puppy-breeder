require_relative 'spec_helper.rb'

describe PuppyBreeder::Breed do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbulll, "Brown", 10)}
	
	describe '#price' do
		it "can change price" do
			pitbull.price = 1000
			expect(pitbull.price).to eq(1000)
		end
	end
end