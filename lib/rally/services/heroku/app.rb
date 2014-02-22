module Rally
  module Services
    class Heroku::App
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def create
        connection.post '/apps' do |req|
          req.body = { name: name }
        end
      end

    private

      def connection
        @connection ||= Faraday.new('https://api.heroku.com') do |builder|
          builder.request :json
          builder.response :json

          builder.adapter Faraday.default_adapter
        end
      end
    end
  end
end
