require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
  let(:pitbull) {PuppyBreeder::Breed.new({:name => "Pitbull", :price => 500})}

  describe '#initialize' do
    it 'initializes with correct parameters' do
      pr = PuppyBreeder::PurchaseRequest.new({:customer => jackson, :breed => pitbull})
      expect(pr.breed.name).to eq('Pitbull')
      expect(pr.customer.name).to eq("Michael Jackson")
      expect(pr.order_status).to eq('pending')
    end
  end
end