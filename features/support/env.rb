require 'bundler/setup'
Bundler.require :default, :test

begin
  require 'dotenv'
  Dotenv.load
rescue LoadError
  # We don't need dotenv on production
end

Rally.load(File.expand_path('../rally.yml', __FILE__))
