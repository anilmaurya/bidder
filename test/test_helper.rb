ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
   include FactoryGirl::Syntax::Methods
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
  include ValidAttribute::Method
end

class ActionController::TestCase
  include Devise::TestHelpers
end
