module Rally
  # Public: A Provider is a Third-Party service that provides resources.
  # Some examples of Providers:
  #
  #   Heroku - provides Apps
  #   GitHub - provides Repos
  #   Papertrail - provides Drains
  #
  # This is an abstract class for Providers to inherit from.
  class Provider
    module DSL

      # Public: Specify the base url where Resources are located for this provider.
      # 
      # base_url - The base url where all api requests go (e.g. https://api.heroku.com)
      #
      # Returns nothing.
      def base_url(base_url)
        define_method :base_url do
          base_url
        end
      end

    end

    extend DSL

    class << self

      # Public: The human friendly name of this provider. This is used by the Runner to
      # determine what provider to call.
      #
      # Returns a String.
      def name
        self.to_s.demodulize.downcase
      end

      # Public: The configuration for this Provider.
      #
      # Returns a Hash.
      def configuration
        Rally.provider_configuration[name]
      end

    protected

      # Internal: Gets called when a provider subclasses this base class. Registers
      # the provider in `Rally.providers` so that it can be used by the Runner.
      #
      # base - The base class (the class that is inheriting this class).
      #
      # Returns nothing.
      def inherited(base)
        Rally.register_provider(base)
      end
    end

    # Public: See Rally:Provider.configuration
    def configuration
      self.class.configuration
    end

    # Internal: Most providers are JSON based REST api's, so we instantiate
    # a Faraday client that can be used, or overriden.
    def connection
      @connection ||= Faraday.new(base_url) do |builder|
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
