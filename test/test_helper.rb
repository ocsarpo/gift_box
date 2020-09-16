ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

module AroundEachTest
  def before_setup
    super
    DatabaseCleaner.clean 
    DatabaseCleaner.start    
  end
end

class ActiveSupport::TestCase
  include AroundEachTest
  
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)
  parallelize(workers: 1)
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def decoded_jwt_token_from_response(token)
    secret = Rails.application.credentials[:devise_jwt_secret_key]    
    token = token.remove("Bearer ")
    JWT.decode(token, secret, true, algorithm: 'HS256')
  end
end
