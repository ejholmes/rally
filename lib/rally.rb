require 'active_support'
require 'faraday'
require 'faraday_middleware'

require 'rally/version'

module Rally
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def register_service(klass)
      services << klass
    end

    def services
      @services ||= []
    end

    def setup(name, options = {})
    end

    def eval(&block)
      evaluator.eval(&block)
    end

  private

    def evaluator
      @evaluator ||= Evaluator.new
    end
  end
end

require 'rally/api'
require 'rally/service'
require 'rally/evaluator'
require 'rally/resource'

require 'rally/services/heroku'
