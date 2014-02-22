module Rally
  class Evaluator
    def initialize(options = {})
      @options = options
    end

    def eval(&block)
      evaluator.instance_eval(&block)
    end

  private

    attr_reader :options

    def evaluator
      locals = options[:locals] || []

      Module.new do
        locals.each do |k,v|
          self.class.__send__ :define_method, k do
            v
          end
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
