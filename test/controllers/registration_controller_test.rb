require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @new_user = {
      user: {
        email: 'oscar3@example.com',
        password: '12345678'
      }
    }

    @exists = {
      user: {
        email: 'oscar@example.com',
        password: '12345678'
      }
    }
  end

  test "registration user" do
    post user_registration_path, params: @new_user

    assert_response :ok
    json = JSON.parse(response.body)
    # user = json["user"].first
    assert_includes json["email"], @new_user[:user][:email]
  end

  test "user already exists" do
    post user_registration_path, params: @exists

    assert_response :bad_request
    
    json = JSON.parse(response.body)
    errors = json["errors"].first
    assert_equal "Bad Request", errors["title"] 
  end
end
