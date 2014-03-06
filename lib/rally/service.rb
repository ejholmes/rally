module Rally
  class Service
    module DSL
      # Public: Specify the base url where Resources are located for this service.
      def base_url(base_url)
        define_method :base_url do
          base_url
        end
      end
    end

    extend DSL

    class << self
      def inherited(base)
        Rally.register_service(base)
      end

      def name
        self.to_s.demodulize.downcase
      end
    end
  end
end
