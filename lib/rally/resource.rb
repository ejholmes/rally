module Rally
  class Resource
    def initialize(provider)
      @provider = provider
    end

    def init(*args)
      create(*args) || fetch(*args)
    end

  private

    attr_reader :provider

    def create
      raise NotImplementedError
    end

    def fetch
      raise NotImplementedError
    end

    def connection
      @connection ||= Faraday.new(provider.base_url) do |builder|
        builder.request :json
        builder.response :json

        builder.adapter Faraday.default_adapter
      end
    end
  end
end
