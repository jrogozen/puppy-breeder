require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:pup) {PuppyBreeder::Puppy.new("Spot", pitbull, "Brown", 20)}

	describe '#initialize' do 
		it "initializes instance of Puppy class" do
			expect(pup).to be_kind_of(PuppyBreeder::Puppy)
		end
	end
end