module Rally
  module Providers
    class Heroku::App < Rally::Resource
      autoload :Addon, 'rally/services/heroku/app/addon'

      attr_reader :id

      # Public: Add a drain to this app.
      #
      # url - String url for the drain.
      #
      # Returns Faraday::Response
      def drain(url)
        connection.post "/apps/#{id}/log-drains" do |req|
          req.body = { url: url }
        end
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
