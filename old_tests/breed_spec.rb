require_relative 'spec_helper.rb'

describe PuppyBreeder::Breed do
	let(:pitbull) {PuppyBreeder::Breed.new("Pitbull", 500)}
	let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
	let(:usher) {PuppyBreeder::Customer.new("Usher")}
	let(:jon) {PuppyBreeder::Breeder.new("Jon")}
	let(:spot) {PuppyBreeder::Puppy.new("Spot", pitbulll, "Brown", 10)}
	
	describe '#price' do
		it "can change price" do
			pitbull.price = 1000
			expect(pitbull.price).to eq(1000)
		end
	end

	describe '#add_to_waitlist' do
		it "adds customers to waitlist" do
			pitbull.add_to_waitlist(jackson)
			pitbull.add_to_waitlist(usher)

			expect(pitbull.wait_list[-1]).to eq(usher)
		end
	end

	describe '#remove_from_waitlist' do
		it "deletes customer from waitlist" do
			pitbull.add_to_waitlist(jackson)
			pitbull.add_to_waitlist(usher)
			pitbull.remove_from_waitlist(jackson)
			expect(pitbull.wait_list[0]).to eq(usher)
		end

		it 'handles non existant deletions' do
			pitbull.remove_from_waitlist(jackson)
			expect(pitbull.wait_list).to be_empty
		end
	end
end