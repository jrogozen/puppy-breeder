require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
	let(:pup) {PuppyBreeder::Puppy.new("Spot", "Pitbull", "Brown")}

	describe '#initialize' do 
		it "initializes instance of puppy class" do
			expect(pup).to be_kind_of(PuppyBreeder::Puppy)
		end

		it "initializes correct color" do
			expect(pup.color).to eq("Brown")
		end
	end
end