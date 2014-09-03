require_relative 'lib/puppy_breeder.rb'

class TerminalClient
	def initialize
		@puppylist = PuppyBreeder::PuppyList.new("Puppy List 1")
		@purchaselist = PuppyBreeder::PurchaseRequestList.new("Purchase Request List 1")
		@prompt = ">> "

		puts "Welcome to Puppy Breeder Terminal (^___^)!!"
		puts "What is your name?"
		print @prompt
		@user = gets.chomp
		puts "Thanks #{@user}! Initializing..."
		@user = PuppyBreeder::Breeder.new("#{@user}")

		# beginnnnnnnn
		start
	end

	def get_command
		print @prompt
		input = gets.chomp.downcase
		split_input = input.split(' ')

		case split_input[0]
		when 'help'
			self.start
		when 'list'
			self.list
		when 'add_breed'
			self.add_breed(split_input)
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
		puts "  add_breed NAME, PRICE - Add a puppy breed with name = NAME and price = PRICE"
		puts "  add_customer NAME - Add a customer with name = NAME"
		puts "  add_puppy NAME, BREED, AGE - Add a puppy"
		puts "  add_purchase_request CUSTOMER, BREED - Add a purchase request"
		puts "  process_purchase_request PURCHASE - Process a purchase request"
		self.get_command
	end

	def list
		@user.all_purchase_requests(@purchaselist)
	end

	def add_breed(input)
		input.shift
		name = input[0]
		price = input[1]
		PuppyBreeder::Breed.new(name, price)
	end
end

TerminalClient.new