module Rally
  class Runner
    def initialize(options = {})
      @options = options
    end

    def eval(*args, &block)
      evaluator.instance_eval(*args, &block)
    end

  private

    attr_reader :options

    def evaluator
      locals = options[:locals] || []

      Module.new do
        locals.each do |local,value|
          self.class.__send__(:define_method, local) { value }
        end

        class << self
          Rally.services.each do |service|
            define_method service.name do
              instance_variable_get(:"@#{service.name}") or
                instance_variable_set(:"@#{service.name}", service.new)
            end
          end
        end
      end
    end
  end
end
