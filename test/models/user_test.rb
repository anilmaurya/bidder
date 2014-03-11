require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def test_validations
    user = build :user
    user.wont have_valid(:username).when(nil)
    user.must have_valid(:username).when('anil')
  end

end
