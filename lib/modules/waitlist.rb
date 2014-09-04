module PuppyBreeder
  class Waitlist
    attr_accessor :customer, :breed, :status
    def initialize(opt={})
      @customer = opt[:customer]
      @breed = opt[:breed]
      @status = opt[:status]
    end
  end
end