require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Puppies do
  # people 
  let(:jon) {PuppyBreeder::Breeder.new("Jon")}
  let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
  let(:usher) {PuppyBreeder::Customer.new("Usher")}
  
  # dogs
  let(:pitbull) {PuppyBreeder::Breed.new({:name => "Pitbull", :price => 500})}
  let(:pug) {PuppyBreeder::Breed.new({:name => "Pug", :price => 200})}
  let(:lucky) do 
    PuppyBreeder.breeds_repo.add("Pitbull", 500)
    PuppyBreeder::Puppy.new({:name => "Lucky", :breed => pitbull, :age => 2})
  end
  let(:bud) {PuppyBreeder::Puppy.new({:name => "Bud", :breed => pitbull, :age => 5})}

  # clean db
  before(:each) {reset_tables}
  before(:each) {create_tables}

  describe '#add' do
    it 'adds puppy' do
      result = PuppyBreeder.puppies_repo.add(lucky)
      expect(result).to eq(1)
    end
  end

  describe '#select_puppy' do
    it 'returns nil for no matches' do
      result = PuppyBreeder.puppies_repo.select_puppy(pitbull)
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'returns array of matching hashes' do
      jon.add_puppy(lucky)
      jon.add_puppy(bud)

      result = PuppyBreeder.puppies_repo.select_puppy(pitbull)
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result[0].name).to eq("Lucky")
    end
  end

  describe '#has_puppy' do
    it 'returns nil for no matches' do
      result = PuppyBreeder.puppies_repo.has_puppy?(pitbull)
      expect(result).to be_nil
    end

    it 'returns true for match(es)' do
      jon.add_puppy(lucky)
      result = PuppyBreeder.puppies_repo.has_puppy?(pitbull)
      expect(result).to eq(true)
    end
  end

  describe '#match_puppy' do
    it 'returns nil for no matches' do
      result = PuppyBreeder.puppies_repo.match_puppy(pitbull)
      expect(result).to be_nil
    end

    it 'returns puppy object of matched puppy' do
      jon.add_puppy(lucky)
      jon.add_puppy(bud)

      result = PuppyBreeder.puppies_repo.match_puppy(pitbull)
      expect(result.name).to eq("Lucky")
    end
  end

  describe '#view_puppies' do
    it 'returns array of all puppies' do
      jon.add_puppy(lucky)
      jon.add_puppy(bud)

      result = PuppyBreeder.puppies_repo.view_puppies
      expect(result).to be_an(Array)
      expect(result.last.name).to eq("Bud")
    end
  end

  describe '#update' do
    it 'updates puppy status' do
      jon.add_puppy(lucky)
      result = PuppyBreeder.puppies_repo.update(lucky, 'crying')
      expect(result[:status]).to eq('crying')
    end
  end
end