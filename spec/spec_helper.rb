ENV["RAILS_ENV"] = 'test'
def zeus_running?
  File.exists? '.zeus.sock'
end

if !zeus_running?
  require 'simplecov'
  SimpleCov.start 'rails'
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'database_cleaner'
require 'capybara/rspec'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist


#require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl, :type => :feature
  config.include Warden::Test::Helpers, :type => :feature
  config.include ValidatePage, :type => :feature
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  config.extend ControllerMacros, :type => :controller
  config.include RSpec::Rails::RequestExampleGroup, type: :request, example_group: {
    file_path: /spec\/api/
  }
  config.include RequestHelper
  #config.order = "default"

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:suite) do
    #DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :truncation
  end

  #config.before(:each) do
  #  DatabaseCleaner.strategy = :transaction
  #end
  #
  #config.before(:each, :js => true) do
  #  DatabaseCleaner.strategy = :truncation
  #end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  def subj
    subject
  end

  #config.include Rails.application.routes.url_helpers

end
