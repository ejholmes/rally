module Rally
  module Providers
    class Heroku::App::Addon < Rally::Resource
    private

      def fetch(plan, config)
        response = connection.get "/apps/#{parent.id}/addons"
        response.body.find { |addon| addon['plan:name'] == plan }
      end

      def create(plan, config)
        connection.post "/apps/#{parent.id}/addons" do |req|
          req.body = { plan: plan, config: config }
        end
      end
    end
  end
end
