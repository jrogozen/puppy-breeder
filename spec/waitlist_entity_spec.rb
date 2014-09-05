require_relative 'spec_helper.rb'

describe PuppyBreeder::Waitlist do
  let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
  let(:pitbull) {PuppyBreeder::Breed.new({:name => "Pitbull", :price => 500})}

  describe '#initialize' do
    it 'initializes with correct parameters' do
      wt = PuppyBreeder::Waitlist.new({:customer => jackson, :breed => pitbull})
      expect(wt.customer.name).to eq("Michael Jackson")
      expect(wt.breed.name).to eq("Pitbull")
    end
  end
end