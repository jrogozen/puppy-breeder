#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_accessor :order_status
  	attr_reader :request_type, :payment_method, :id

  	def initialize(puppy, opt={})
  		@puppy = puppy
  		@request_type = opt[:request_type]
  		@payment_method = opt[:payment_method]
  		@order_status = "pending"
  		@id = rand(100000)
  	end
  end
end