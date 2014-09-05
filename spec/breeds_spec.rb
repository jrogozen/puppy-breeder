require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Breeds do
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

  describe '#add' do
    it 'adds breed to database' do
      result = PuppyBreeder.breeds_repo.add('Pitbull', 500)
      expect(result.name).to eq('Pitbull')
    end
  end

  describe '#show_breed' do
    it '#returns nil when no matching breeds' do
      result = PuppyBreeder.breeds_repo.show_breed('Pitbull')
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it '#returns array of matching breeds (should only be 1)' do
        PuppyBreeder.breeds_repo.add('Pitbull', 500)
        PuppyBreeder.breeds_repo.add('Corgi', 25)

        result = PuppyBreeder.breeds_repo.show_breed('Corgi')
        expect(result).to be_an(Array)
        expect(result.length).to eq(1)
    end
  end

  describe '#check_for_dup' do
    it 'returns true if breed already exists in repo' do
      PuppyBreeder.breeds_repo.add('Pitbull', 500)
      result = PuppyBreeder.breeds_repo.check_for_dup('Pitbull')
      expect(result).to eq(true)
    end

    it 'returns false if breed is not yet in repo' do
      result = PuppyBreeder.breeds_repo.check_for_dup('Pitbull')
      expect(result).to eq(false)
    end
  end
end