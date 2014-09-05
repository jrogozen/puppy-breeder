require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do 
  describe '#initialize' do
    it 'initializes parameters correctly' do
      lucky = PuppyBreeder::Puppy.new({:name => "Lucky"})

      expect(lucky.name).to eq("Lucky")
      expect(lucky.status).to eq("available")
      expect(lucky.id).to be_nil
    end
  end
end