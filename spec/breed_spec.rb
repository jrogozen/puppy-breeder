require_relative 'spec_helper.rb'

describe PuppyBreeder::Breed do 
  describe '#initialize' do
    it 'initializes with correct parameters' do
      pitbull = PuppyBreeder::Breed.new({:name => "Pitbull", :price => 200})

      expect(pitbull.price).to eq(200)
      expect(pitbull.name).to eq("Pitbull")
    end
  end
end