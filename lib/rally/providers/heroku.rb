module Rally
  module Providers
    class Heroku < Rally::Provider
      autoload :App, 'rally/providers/heroku/app'

      base_url 'https://api.heroku.com'

      def app(name)
        app = App.new(self)
        app.init(name)
        yield app if block_given?
        app
      end

      def connection
        super.tap do |conn|
          conn.headers['Accept'] = 'application/vnd.heroku+json; version=3'
          conn.headers['Authorization'] = "Basic #{Base64.encode64("#{configuration.username}:#{configuration.password}")}"
        end
      end
    end
  end
end
