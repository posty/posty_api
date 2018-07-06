ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environment'

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
end
