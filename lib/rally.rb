require 'active_support'
require 'faraday'
require 'faraday_middleware'

require 'rally/version'

module Rally
  extend ActiveSupport::Autoload

  autoload :API
  autoload :Service
  autoload :Resource
  autoload :Runner

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
      @evaluator ||= Runner.new
    end
  end
end

require 'rally/services/heroku'
