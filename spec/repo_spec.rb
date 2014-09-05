require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Repo do 
  describe '#clean_hash' do
    it 'properly converts keys to symbols' do
      x = PuppyBreeder::Repos::Repo.new
      hash = {"hey" => 1, "be" => 2, "task" => 100}

      hash = x.clean_hash(hash)
      expect(hash.key(1)).to be_a(Symbol)
    end
  end
end