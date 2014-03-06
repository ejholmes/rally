module Rally
  # Public: A Resource is provided by Providers. A Resource has methods to
  # transform and modify the resource. Some examples of things that a 
  # Resource might do:
  #
  #   * An App Resource might have methods to add drains to it.
  #   * A Repo Resource might have methods to add webhooks to it.
  #
  # This is an abstract class for sub classes to inherit from.
  class Resource

    # Internal: We provide the Resource with it's parent provider.
    #
    # Returns the Resource.
    def initialize(provider)
      @provider = provider
    end

    # Public: This is the primary interface into creating Resources. Resources
    # should always be idempotent; we should be able to call this method any
    # number of times and always get the same Resource.
    #
    # Returns nothing.
    def init(*args)
      fetch(*args) || create(*args)
    end

  private

    attr_reader :provider

    # Internal: Implement the logic to create your Resource.
    def create
      raise NotImplementedError
    end

    # Internal: Implement the logic to fetch your Resource.
    def fetch
      raise NotImplementedError
    end

    # Internal: Most providers are JSON based REST api's, so we instantiate
    # a Faraday client that can be used, or overriden.
    def connection
      @connection ||= Faraday.new(provider.base_url) do |builder|
        build_middleware(builder)
        builder.adapter Faraday.default_adapter
      end
    end

    # Internal: Builds the faraday middleware stack. Override this if you want
    # different middleware.
    def build_middleware(builder)
      builder.request :json
      builder.response :json
    end
  end
end
