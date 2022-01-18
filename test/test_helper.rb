# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

OmniAuth.config.test_mode = true
# OmniAuth.config.add_mock(
#   :github,
#   provider: 'github',
#   uid: '12345',
#   info: { name: 'Github User', email: 'github@github.com' }
# )
# Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
