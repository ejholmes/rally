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

    # Internal: We inject the Provider into the Resource. If the injected Provider is an instance
    # of a Resource sub class, then we consider that to be the parent of this Resource.
    #
    # Returns the Resource.
    def initialize(provider)
      if provider.is_a?(Resource)
        @parent = provider
        @provider = provider.provider
      else
        @provider = provider
      end
    end

    # Public: This is the primary interface into creating Resources. Resources
    # should always be idempotent; we should be able to call this method any
    # number of times and always get the same Resource.
    #
    # Returns nothing.
    def init(*args)
      fetch(*args) || create(*args)
    end

  protected

    attr_reader :provider
    attr_reader :parent

    # Internal: Implement the logic to create your Resource.
    def create(*args)
      raise NotImplementedError, 'Implement a method to create the resource.'
    end

    # Internal: Implement the logic to fetch your Resource.
    def fetch(*args)
      raise NotImplementedError, 'Implement a method to fetch the resource.'
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
