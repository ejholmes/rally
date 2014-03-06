module Rally
  class Service
    module DSL

      # Public: Specify the base url where Resources are located for this service.
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

      # Public: The human friendly name of this service. This is used by the Runner to
      # determine what service to call.
      #
      # Returns a String.
      def name
        self.to_s.demodulize.downcase
      end

    protected

      # Internal: Gets called when a service subclasses this base class. Registers
      # the service in `Rally.services` so that it can be used by the Runner.
      #
      # base - The base class (the class that is inheriting this class).
      #
      # Returns nothing.
      def inherited(base)
        Rally.register_service(base)
      end
    end
  end
end
