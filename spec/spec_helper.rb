ENV['RACK_ENV'] = 'test'

require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console
])

SimpleCov.start

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require './app'
require_relative './support/database_helper'
require_relative './support/registration_helper'

Capybara.app = MakersBnB

RSpec.configure do |config|
  config.include DatabaseHelper
  config.include RegistrationHelper

  config.before(:each) do
    truncate_table
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
