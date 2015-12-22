require "simplecov"
SimpleCov.start

require "helpers"
require "./lib/go_fish"

RSpec.configure do |config|
  config.include Helpers
end
