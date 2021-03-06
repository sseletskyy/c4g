require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Contest4good
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Kyiv'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.view_specs false
      g.helper_specs false
    end

    config.to_prepare do
      Devise::SessionsController.layout proc { |controller| action_name == 'new' ? "login" : "application" }
      Devise::PasswordsController.layout proc { |controller| action_name == 'new' ? "login" : "application" }
      #Devise::InvitationsController.layout proc { |controller| action_name == 'accept' ? "login" : "application" }
    end

    I18n.config.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:ru, :'uk-UA', :en]
    config.i18n.default_locale = :ru

    config.active_record.time_zone_aware_attributes = false

    config.active_record.schema_format = :ruby
    # :sql will cause an error when you do db:migrate on heroku (postgresql_database_tasks.rb:55:in `structure_dump')

    #config.paths.add "app/api", glob: "**/*.rb"
    #config.autoload_paths += Dir["#{Rails.root}/app/api/*"]

    #config.assets.paths << Rails.root.join('vendor','assets','fonts')
    #config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

  end
end

require 'contest4good' # to load global constants