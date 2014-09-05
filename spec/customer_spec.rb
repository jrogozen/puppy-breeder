require_relative 'spec_helper.rb'

describe PuppyBreeder::Customer do 
  # people 
  let(:jon) {PuppyBreeder::Breeder.new("Jon")}
  let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
  let(:usher) {PuppyBreeder::Customer.new("Usher")}
  
  # dogs
  let(:pitbull) {PuppyBreeder::Breed.new({:name => "Pitbull", :price => 500})}
  let(:pug) {PuppyBreeder::Breed.new({:name => "Pug", :price => 200})}
  let(:lucky) {PuppyBreeder::Puppy.new({:name => "Lucky", :breed => pitbull, :age => 2})}
  let(:bud) {PuppyBreeder::Puppy.new({:name => "Bud", :breed => pitbull, :age => 2})}

  # clean db
  before(:each) {reset_tables}
  before(:each) {create_tables}

  describe '#create_purchase_request' do
    it 'creates a new purchase request entity' do
      result = jackson.create_purchase_request(pitbull)
      expect(result.breed).to eq(pitbull)
    end

    it 'sets purchase request id' do
      result = jackson.create_purchase_request(pitbull)
      expect(result.id).to eq(1)
    end
  end
end