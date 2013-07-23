$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'openid/extensions/teams'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.mock_with :rspec do |configuration|
    configuration.syntax = :expect
  end
end
