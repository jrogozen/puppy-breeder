require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
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

	describe '#add_puppy' do
		it 'adds puppy to the database' do
			result = jon.add_puppy(lucky)
			expect(result).to eq(1)
		end
	end

	describe '#create_purchase_request' do
		it 'creates new purchase request' do
			result = jon.create_purchase_request(jackson, pitbull)
			expect(result.breed).to eq(pitbull)
		end

		it 'sets the purchase request id' do
			result = jon.create_purchase_request(jackson, pitbull)
			expect(result.id).to eq(1)
		end
	end

	describe '#review_purchase_request' do
		it 'returns the correct purchase request' do
			pr = jon.create_purchase_request(jackson, pitbull)
			result = jon.review_purchase_request(pr.id)
			expect(result.breed.name).to eq("Pitbull")
		end
	end

	describe '#all_purchase_requests' do
		it 'returns an array of all purchase requests' do

			jon.create_purchase_request(jackson, pitbull)
			jon.create_purchase_request(jackson, pug)
			result = jon.all_purchase_requests

			# return an array of hashes
			expect(result[1].breed.name).to eq("Pug")
		end
	end

	describe '#update_purchase_request' do
		it 'updates order status in database' do
			pr = jon.create_purchase_request(jackson, pitbull)
			result = jon.update_purchase_request(pr.id, 'denied')

			expect(result[:order_status]).to eq('denied')

		end
	end

  describe '#add_to_waitlist' do
    it 'adds customer to waitlist database' do
       result = jon.add_to_waitlist(jackson, pitbull)
       expect(result[:customer]).to eq("Michael Jackson")
    end
  end

  describe '#update_waitlist_status' do
    it 'sets status to completed' do
      jon.add_to_waitlist(jackson, pitbull)
      result = jon.update_waitlist_status(jackson, pitbull, 'completed')
      expect(result[:status]).to eq("completed")
    end
  end

	describe '#complete_purchase_request' do
		it 'updates order status to completed' do
      pr = jon.create_purchase_request(jackson, pitbull)
      result = jon.complete_purchase_request(pr.id)
      
      expect(result[:order_status]).to eq('completed')
		end
	end

  describe '#hold_purchase_request' do
    it 'adds customer to waitlist' do
      pr = jon.create_purchase_request(jackson, pitbull)
      result = jon.hold_purchase_request(pr.id)
      expect(result[:customer]).to eq("Michael Jackson")
    end
  end

  describe '#process_purchase_request' do
    context 'successful order' do
      it 'changes puppy status to sold' do
        jon.add_puppy(lucky)
        pr = jon.create_purchase_request(jackson, pitbull)
        jon.process_purchase_request(pr.id)

        result = PuppyBreeder.puppies_repo.view_puppies
        expect(result.first.status).to eq("sold")
      end

      it 'changes the purchase request to completed' do
        jon.add_puppy(lucky)
        pr = jon.create_purchase_request(jackson, pitbull)
        jon.process_purchase_request(pr.id)

        result = jon.review_purchase_request(pr.id)
        expect(result.order_status).to eq("completed")
      end

      it 'change waitlist status to complete' do
        # set waitlist
        jon.add_puppy(lucky)
        pr = jon.create_purchase_request(jackson, pitbull)
        jon.process_purchase_request(pr.id)
        pr2 = jon.create_purchase_request(usher, pitbull)
        jon.process_purchase_request(pr2.id)

        # add new puppy
        jon.add_puppy(bud)
        jon.process_purchase_request(pr2.id)
        result = PuppyBreeder.waitlist_repo.completed_waitlist(pr2.breed)

        expect(result.first.status).to eq('completed')
      end
    end

    context 'order must be put on hold' do
      it 'adds customer to the wait list' do
        # set waitlist
        jon.add_puppy(lucky)
        pr = jon.create_purchase_request(jackson, pitbull)
        jon.process_purchase_request(pr.id)
        pr2 = jon.create_purchase_request(usher, pitbull)
        jon.process_purchase_request(pr2.id)

        result = PuppyBreeder.waitlist_repo.show_waitlist(pr2.breed)
        expect(result.first.customer.name).to eq('Usher')
      end

      it 'changes the purchase request to hold' do
        jon.add_puppy(lucky)
        pr = jon.create_purchase_request(jackson, pitbull)
        jon.process_purchase_request(pr.id)
        pr2 = jon.create_purchase_request(usher, pitbull)
        jon.process_purchase_request(pr2.id)

        result = jon.review_purchase_request(pr2.id)
        expect(result.order_status).to eq('hold')
      end
    end
  end

  describe '#view_select_orders' do
    it 'returns array of completed orders' do
      pr1 = jon.create_purchase_request(jackson, pitbull)
      pr2 = jon.create_purchase_request(jackson, pug)
      pr3 = jon.create_purchase_request(usher, pitbull)
      jon.complete_purchase_request(pr2.id)

      result = jon.view_select_orders("completed")
      expect(result[0].customer.name).to eq("Michael Jackson")

    end

    it 'returns array of pending orders' do
      pr1 = jon.create_purchase_request(jackson, pitbull)
      pr2 = jon.create_purchase_request(jackson, pug)
      pr3 = jon.create_purchase_request(usher, pitbull)

      result = jon.view_select_orders("pending")
      expect(result[2].customer.name).to eq("Usher")
    end

    it 'returns array of hold(ed) orders' do
      pr1 = jon.create_purchase_request(jackson, pitbull)
      pr2 = jon.create_purchase_request(jackson, pug)
      pr3 = jon.create_purchase_request(usher, pitbull)

      jon.hold_purchase_request(pr2.id)

      result = jon.view_select_orders("hold")
      expect(result[0].customer.name).to eq("Michael Jackson")
    end
  end
end