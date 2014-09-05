require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Purchases do 
  # people 
  let(:jon) {PuppyBreeder::Breeder.new("Jon")}
  let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
  let(:usher) {PuppyBreeder::Customer.new("Usher")}
  
  # dogs
  let(:pitbull) {PuppyBreeder::Breed.new({:name => "Pitbull", :price => 500})}
  let(:pug) {PuppyBreeder::Breed.new({:name => "Pug", :price => 200})}
  let(:lucky) {PuppyBreeder::Puppy.new({:name => "Lucky", :breed => pitbull, :age => 2})}
  let(:bud) {PuppyBreeder::Puppy.new({:name => "Bud", :breed => pitbull, :age => 5})}

  # purchase request
  let(:pr) {PuppyBreeder::PurchaseRequest.new({:breed => pitbull, :customer => jackson})}

  describe '#add' do
    it 'sets id of 1st purchase request' do
      result = PuppyBreeder.purchases_repo.add(pr)
      expect(result).to eq(1)
    end

    it 'correctly increments id' do
      PuppyBreeder.purchases_repo.add(pr)
      result = PuppyBreeder.purchases_repo.add(pr) 
      expect(result).to eq(2)
    end
  end

  describe '#update' do
    it 'correctly changes order status' do
      PuppyBreeder.purchases_repo.add(pr)
      result = PuppyBreeder.purchases_repo.update(pr.id, 'fluffy')
      expect(result[:order_status]).to eq('fluffy')
    end
  end

  describe '#view_by_id' do
    it 'returns empty array when no match' do
      result = PuppyBreeder.purchases_repo.view_by_id(100)
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'returns correct purchase request based on id' do
      PuppyBreeder.purchases_repo.add(pr)
      result = PuppyBreeder.purchases_repo.view_by_id(1)
      expect(result.customer.name).to eq('Michael Jackson')
    end
  end

  describe '#view_by_query' do
    it 'returns array of matching objects' do
      PuppyBreeder.purchases_repo.add(pr)
      result = PuppyBreeder.purchases_repo.view_by_query('pending')
      expect(result.first.customer.name).to eq('Michael Jackson')
    end
  end
end