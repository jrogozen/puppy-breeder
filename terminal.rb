require_relative 'app.rb'

class TerminalClient
	def initialize
		@prompt = ">> "
		@hash_line = '########################'
		@dash = '--------------------------'

		puts "Welcome to Puppy Breeder Terminal (^___^)!!"
		puts "What is your name?"
		print @prompt
		@user = gets.chomp
		puts "Thanks #{@user}! Initializing..."
		@user = PuppyBreeder::Breeder.new("#{@user}")

		# #put some data in there
		# pitbull = PuppyBreeder::Breed.new("Pitbull", 500)
		# jackson = PuppyBreeder::Customer.new("Michael Jackson")
		# lucky = PuppyBreeder::Puppy.new({:name => "Lucky", :breed => pitbull, :age => 2})
		# @user.add_puppy(lucky)
		# @user.create_purchase_request(jackson, pitbull)

		# LIMITATIONS
		# has to enter the breed price everytime.

		# beginnnnnnnn
		start
	end

	def get_command
		print @prompt
		input = gets.chomp
		split_input = input.split(',')
		split_input.each {|str| str.slice! ','; str.slice! ' '}

		case split_input[0]
		when 'help'
			self.start
		when 'list'
			self.list
		when 'add_breed'
			self.add_breed(split_input)
		when 'add_puppy'
			self.add_puppy(split_input)
		when 'create_purchase_request'
			self.create_purchase_request(split_input)
		when 'process_purchase_request'
			self.process_purchase_request(split_input)
		when 'exit'
			exit
		else
			puts "Sorry, did not recognize #{split_input[0]}. Please retry."
			self.get_command
		end


	end

	def start
		puts "Available Commands:"
		puts "  help - Show all commands again"
		puts "  list - Show all purchase requests"
		puts "  add_breed, NAME, BREED_PRICE"
		puts "  add_puppy, NAME, BREED, BREED_PRICE, AGE - Add a puppy"
		puts "  create_purchase_request, CUSTOMER, BREED, BREED_PRICE - Add a purchase request"
		puts "  process_purchase_request, PURCHASE_ID - Process a purchase request"
		self.get_command
	end

	def list
		data = @user.all_purchase_requests
		puts "Purchase Requests:"
		puts "#{@hash_line}"
		data.each do |pr|
			puts "Id: #{pr.id}"
			puts "Customer: #{pr.customer.name}"
			puts "Breed: #{pr.breed.name}"
			puts "Order Status: #{pr.order_status}"
			puts "#{@dash}"
		end
		self.get_command
	end

	def add_breed(input)
		name = input[1]
		price = input[2]

		if PuppyBreeder.breeds_repo.check_for_dup(name)
			puts "#{name} has already been added to the database."
		else
			PuppyBreeder.breeds_repo.add(name, price)
			puts "#{name} added to database."
		end

		self.get_command
	end

	def add_puppy(input)
		# need name, breed, age, status, id
		name = input[1]
		breed_name = input[2].capitalize

		if PuppyBreeder.breeds_repo.check_for_dup(breed_name)
			# just create entity
			breed = PuppyBreeder::Breed.new(breed_name, input[3])
		else
			# add to the database and then create entity
			add_breed([0, breed_name, input[3]])
		end

		# to get breed price we'd have to check a repo. add later?
		age = input[4]

		# create puppy instance
		pup = PuppyBreeder::Puppy.new({:name => name, :breed => breed, :age => age })

		# add puppy to db
		@user.add_puppy(pup)
		puts "#{name} added to database."

		self.get_command
	end

	def create_purchase_request(input)
		# need customer, breed
		customer = PuppyBreeder::Customer.new(input[1].capitalize)
		breed = PuppyBreeder::Breed.new(input[2].capitalize, input[3])

		# add purchase to db
		@user.create_purchase_request(customer, breed)
		puts "Purchase Request added to Database."

		self.get_command
	end

	def process_purchase_request(input)
		@user.process_purchase_request(input[1])
		puts "Order #{input[1]} processed."

		self.get_command
	end

end

TerminalClient.new