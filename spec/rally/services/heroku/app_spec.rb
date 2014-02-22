require 'spec_helper'

describe Rally::Services::Heroku::App do
  subject(:app) { described_class.new('dashboard') }

  describe '#create' do
    it 'creates the app if it does not exist' do
      p app.create
    end
  end
end
