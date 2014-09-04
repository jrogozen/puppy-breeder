#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_accessor :order_status, :id
  	attr_reader :customer, :breed

  	def initialize(opt = {})
      @breed = opt[:breed]
      @customer = opt[:customer]
  		@order_status = opt[:order_status] || "pending"

      # id is set by Purchases Repo
      @id = opt[:id]
  	end

  end
end