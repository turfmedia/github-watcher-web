require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not create a user with invalid auth parameter" do 
  	user = User.create_with_omniauth([])
  	user_s = User.create_with_omniauth("")
  	assert user.nil?
  	assert user_s.nil?
  end

  test "should not create a user with empty auth parameter/fields" do 
  	user = User.create_with_omniauth()
  	
  	auth = OmniAuth::AuthHash.new
  	auth["credentials"] = {}
  	auth["info"] = {}

    auth["uid"] = ""
    auth["credentials"]["token"] = ""
    auth["info"]["email"] = ""

  	user2 = User.create_with_omniauth(auth)

  	assert user.new_record?
  	assert user2.errors.messages[:uid].first.eql?("can't be blank")
  	assert user2.errors.messages[:token].first.eql?("can't be blank")
  	assert user2.errors.messages[:email].first.eql?("can't be blank")
  end

  test "should not create a user without presence validates" do 
  	user = User.create_with_omniauth()
  	
  	auth = OmniAuth::AuthHash.new
  	auth["credentials"] = {}
  	auth["info"] = {}

    auth["uid"] = "995942"
    auth["provider"] = "github"
    auth["username"] = "3lviend"
    auth["name"] = "Elvin Alvian Siagian"
    auth["credentials"]["token"] = "98cdcee3d59d45e15f4774a3cf56718899a63094"
    auth["info"]["email"] = "henryss_10@yahoo.com"

  	user = User.create_with_omniauth(auth)

  	assert_not user.new_record?
  end

end
