module Rally
  class Service
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
