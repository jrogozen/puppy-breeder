#require this file in your spec files to help DRY up your tests
require 'rspec'
require 'pry-byebug'
require_relative '../app.rb'

RSpec.configure do |config|
  
  config.before(:each) {reset_tables}
  config.before(:each) {create_tables}

end

def reset_tables
	PuppyBreeder::Repos::drop_tables
end

def create_tables
	PuppyBreeder::Repos::create_tables
end

