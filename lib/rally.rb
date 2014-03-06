require 'active_support'
require 'faraday'
require 'faraday_middleware'

require 'rally/version'

module Rally
  extend ActiveSupport::Autoload

  autoload :API
  autoload :Provider
  autoload :Resource
  autoload :Runner

  class << self

    # Public: Logger instance to use.
    # 
    # Returns a Logger instance.
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    # Public: Registers a provider to be used by the Runner.
    #
    # klass - A class that inherits from Rally::Provider.
    #
    # Returns nothing.
    def register_provider(klass)
      providers << klass
    end

    # Public: A list of all the registered Providers.
    #
    # Returns an Array of Providers.
    def providers
      @providers ||= []
    end

    # Public: Evals some code in the Rally::Runner.
    def eval(*args, &block)
      evaluator.eval(*args, &block)
    end

  private

  # Internal: A Rally::Runner instance to evaluate code inside.
    def evaluator
      @evaluator ||= Runner.new
    end
  end
end

require 'rally/providers/heroku'
