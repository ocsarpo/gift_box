require 'test_helper'

class V1::SessionsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers # Rails >= 5
        
    test 'create session with valid email & id' do
        post v1_sessions_path, params: {email: 'oscar@example.com', password: '12345678'}
        assert_response :created
    end

    test 'create session with imvalid email & id' do
        post v1_sessions_path, params: {email: 'oscar@example.com', password: '22222222' }
        assert_response :unauthorized
    end

    # test 'destroy' do
        
    # end
end