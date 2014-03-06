module Rally
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
  end
end
