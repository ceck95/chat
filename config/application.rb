require File.expand_path('../boot', __FILE__)
require File.expand_path('../csrf_protection', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Moscow'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.delete Rack::Lock
    config.middleware.use FayeRails::Middleware, mount: '/faye', :timeout => 25
    # if defined?(PhusionPassenger)
    #   PhusionPassenger.advertised_concurrency_level = 0
    # end

    if Rails.env.development?
      config.before_configuration do
        env_file = File.join(Rails.root, 'config', 'local_env.yml')
        YAML.load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value
        end if File.exists?(env_file)
      end
    end
    # app = lambda do |env|
    #   if env['PATH_INFO'] == '/faye'
    #     ws = Faye::WebSocket.new(env)

    #     timer = EM.add_periodic_timer(1) do
    #       ws.send(Time.now.to_s)
    #     end

    #     ws.on :message do |event|
    #       ws.send("You sent: #{event.data}")
    #     end

    #     ws.on :close do |event|
    #       EM.cancel_timer(timer)
    #       ws = nil
    #     end

    #     # Return async Rack response
    #     ws.rack_response

    #   else
    #     [404, { "Content-Type" => "text/plain" }, ["Not found"]]
    #   end
    end

    # See https://www.phusionpassenger.com/library/config/tuning_sse_and_websockets/
    if defined?(PhusionPassenger)
      PhusionPassenger.advertised_concurrency_level = 0
    end
  end
end
