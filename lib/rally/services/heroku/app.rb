module Rally
  module Services
    class Heroku::App < Rally::Resource

      attr_reader :id

      def init(name)
        fetch(name) || create(name)
      end

    private

      def create(name)
        response = connection.post '/apps' do |req|
          req.body = { name: name }
        end
        process response
      end

      def fetch(name)
        response = connection.get "/apps/#{name}"
        return if response.status == 404
        process response
      end

      def process(response)
        @id = response.body['id']
        response
      end
    end
  end
end
