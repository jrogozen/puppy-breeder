require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Waitlist do 
  # people 
  let(:jon) {PuppyBreeder::Breeder.new("Jon")}
  let(:jackson) {PuppyBreeder::Customer.new("Michael Jackson")}
  let(:usher) {PuppyBreeder::Customer.new("Usher")}
  
  # dogs
  let(:pitbull) {PuppyBreeder::Breed.new({:name => "Pitbull", :price => 500})}
  let(:pug) {PuppyBreeder::Breed.new(:name => "Pug", :price => 300)}
  let(:lucky) do 
    PuppyBreeder.breeds_repo.add("Pitbull", 500)
    PuppyBreeder::Puppy.new({:name => "Lucky", :breed => pitbull, :age => 2})
  end
  let(:bud) {PuppyBreeder::Puppy.new({:name => "Bud", :breed => pitbull, :age => 2})}

  # clean db
  before(:each) {reset_tables}
  before(:each) {create_tables}

  describe '#add' do
    it 'adds waitlist to the database' do
      result = PuppyBreeder.waitlist_repo.add(jackson, pitbull)
      expect(result[:customer]).to eq("Michael Jackson")
    end
  end

  describe '#update' do
    it 'updates waitlist status in database' do
      PuppyBreeder.waitlist_repo.add(jackson, pitbull)
      result = PuppyBreeder.waitlist_repo.update(jackson, pitbull, 'who cares?')

    end
  end

  describe '#only_completed' do
    it 'returns array of waitlist entries with completed status' do
      PuppyBreeder.waitlist_repo.add(jackson, pitbull)
      PuppyBreeder.waitlist_repo.update(jackson, pitbull, 'completed')
      result = PuppyBreeder.waitlist_repo.completed_waitlist(pitbull)

      expect(result.first.customer.name).to eq("Michael Jackson")
    end
  end

  describe '#show_waitlist' do
    it 'returns array of only pending waitlist items' do
      PuppyBreeder.waitlist_repo.add(jackson, pitbull)
      result = PuppyBreeder.waitlist_repo.show_waitlist(pitbull)

      expect(result.first.customer.name).to eq("Michael Jackson")
    end
  end

  describe '#has_waitlist?' do
    it 'returns nil if there is no waitlist for a breed' do
      result = PuppyBreeder.waitlist_repo.has_waitlist?(pitbull)
      expect(result).to be_nil
    end

    it 'returns true if there is a waitlist for a breed' do
      PuppyBreeder.waitlist_repo.add(jackson, pitbull)
      result = PuppyBreeder.waitlist_repo.has_waitlist?(pitbull)
      expect(result).to be(true)
    end
  end
end