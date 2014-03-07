require 'base64'

module Rally
  module Providers
    class Heroku::App < Rally::Resource
      autoload :Drain, 'rally/providers/heroku/app/drain'
      autoload :Addon, 'rally/providers/heroku/app/addon'

      attr_reader :id

      # Public: Add a drain to this app.
      #
      # url - String url for the drain.
      #
      # Returns a Faraday::Response.
      def drain(url)
        drain = Drain.new(self)
        drain.init(url)
      end

      # Public: Add a deploy hook to the app.
      # 
      # Returns a Faraday::Response
      def hook(type)
        config = configuration.hooks[type.to_s]
        addon "deployhooks:#{type}", config
      end

      # Public: Add an addon to this app.
      #
      # plan   - The plan for the addon (e.g. 'cloudamqp:bunny').
      # config - A hashie of config options to create the addon with.
      #
      # Returns a Faraday::Response.
      def addon(plan, config)
        addon = Addon.new(self)
        addon.init(plan, config)
      end

    private

      def fetch(name)
        response = connection.get "/apps/#{name}"
        return if response.status == 404
        process response
      end

      def create(name)
        response = connection.post '/apps' do |req|
          req.body = { name: name }
        end
        process response
      end

      def process(response)
        @id = response.body['id']
        response
      end
    end
  end
end
