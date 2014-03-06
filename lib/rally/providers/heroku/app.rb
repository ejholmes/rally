module Rally
  module Providers
    class Heroku::App < Rally::Resource
      autoload :Drain, 'rally/providers/heroku/app/drain'

      attr_reader :id

      # Public: Add a drain to this app.
      #
      # url - String url for the drain.
      #
      # Returns Faraday::Response
      def drain(url)
        drain = Drain.new(self)
        drain.init(url)
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
