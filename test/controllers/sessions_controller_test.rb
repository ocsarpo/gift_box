require 'test_helper'
require 'devise/jwt/test_helpers'

class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers # Rails >= 5
        
    test 'create session with valid email & id' do
        post user_session_path, params: { user: {email: 'oscar@example.com', password: '12345678'}}
        assert_response :ok
        assert_not_empty response.headers["Authorization"], "returns JWT token in authorization header"
        
        assert decoded_jwt_token_from_response(response.headers["Authorization"])
    end

    test 'create session with imvalid email & id' do
        post user_session_path, params: {email: 'oscar@example.com', password: '22222222' }
        assert_response :unauthorized
    end

    test 'destroy' do
        delete destroy_user_session_path

        assert_response :ok
    end
end