require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment.rb', __dir__)

require 'rspec/rails'
require 'factory_bot_rails'
require 'mongoid-rspec'
require 'capybara/rspec'
require 'rspec/collection_matchers'
require 'dotenv'
Dotenv.load

Mongoid.configure do |config|
  config.connect_to('helena_adminstration_test')
end

Mongo::Logger.logger.level = Logger::WARN # Set log level to DEBUG to see everything

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include HelenaAdministration::Engine.routes.url_helpers

  config.include ActionView::RecordIdentifier, type: :feature

  config.include Mongoid::Matchers, type: :model

  # We don't want write FactoryBot all the time
  config.include FactoryBot::Syntax::Methods

  config.infer_spec_type_from_file_location!

  config.order = :random
  config.profile_examples = 30

  config.after(:each) do
    Mongoid.purge!
  end
end
