module Rally
  module Services
    class Heroku < Rally::Service
      def app
        puts 'foo'
      end
    end
  end
end
