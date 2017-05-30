require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlayMe
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

development:
  FB_ID: "1363780467034632"
  FB_SECRET: "575dd4f2da4f4461a245e75df202ad71"

production:
  FB_ID: "431355847248799"
  FB_SECRET: "75ff5e607e04542d9f3faf16a61c9e8f"
