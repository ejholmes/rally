module Rally
  class Resource
    def initialize(service)
      @service = service
    end

    def init(*args)
      create(*args) || fetch(*args)
    end

  private

    attr_reader :service

    def create
      raise NotImplementedError
    end

    def fetch
      raise NotImplementedError
    end

    def connection
      @connection ||= Faraday.new(service.base_url) do |builder|
        builder.request :json
        builder.response :json

        builder.adapter Faraday.default_adapter
      end
    end
  end
end
