module Rally
  module Providers
    class Heroku::App::Drain < Rally::Resource
    private

      def fetch(url)
        response = connection.get "/apps/#{parent.id}/log-drains"
        response.body.find { |drain| drain['url'] == url }
      end

      def create(url)
        connection.post "/apps/#{parent.id}/log-drains" do |req|
          req.body = { url: url }
        end
      end
    end
  end
end
