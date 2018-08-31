require 'bundler/setup'
require 'must_be_ordered'

MODELS = File.join(File.dirname(__FILE__), 'models')
$LOAD_PATH.unshift(MODELS)

Dir[File.join(MODELS, '*.rb')].sort.each do |filename|
  name = File.basename(filename, '.rb')
  autoload name.camelize.to_sym, name
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

ActiveRecord::Migration.verbose = false

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    Support::Database.setup_db
  end

  config.before do
    Support::Database.clear_db
    Support::Database.seed_db
  end
end
