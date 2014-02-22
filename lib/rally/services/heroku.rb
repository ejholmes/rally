module Rally
  module Services
    class Heroku < Rally::Service
      autoload :App, 'rally/services/heroku/app'

      def app(name)
        app = App.new(name)
        app.create
        yield app if block_given?
        app
      end
    end
  end
end
