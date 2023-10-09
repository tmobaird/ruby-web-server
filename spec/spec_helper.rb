require_relative "../lib/server"
require_relative "../lib/router"
require_relative "../lib/request"
require_relative "../lib/response"
require_relative "../lib/routes"
require "httparty"
@thread = nil

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = true
  config.profile_examples = 10
  config.order = :random

  config.before(:suite) do
    server = Server.new(8080, Logger.new(nil))
    @thread = Thread.new { server.start }
  end

  config.after(:suite) do
    @thread&.terminate!
  end
end
