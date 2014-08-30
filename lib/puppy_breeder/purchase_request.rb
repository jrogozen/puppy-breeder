#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_accessor :order_status, :id
  	attr_reader :request_type, :payment_method, :customer, :breed

  	def initialize(breed, customer, opt={})
  		@breed, @customer = breed, customer
  		@request_type = opt[:request_type]
  		@payment_method = opt[:payment_method]
  		@order_status = "pending"

      # id is set by PurchaseRequestList class
      @id = nil
  	end

  end
end