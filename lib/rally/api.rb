require 'grape'
require 'grape-entity'

module Rally
  class API < Grape::API
    logger Rally.logger

    version 'v1', using: :header, vendor: 'rally'
    format :json
    default_format :json

    namespace :apps do
      desc 'Setup an app'
      params do
        requires :name, type: String
        optional :recipe, type: String
      end
      post do
        Rally.setup(params.name, recipe: params.recipe)
      end
    end
  end
end
