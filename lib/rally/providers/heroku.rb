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
    end
  end
end
