require 'spec_helper'

describe Rally::Services::Heroku do
  subject(:service) { described_class.new }

  describe '#app' do
    subject(:app) { service.app('my-app') }

    before do
      Rally::Services::Heroku::App.any_instance.stub(:init).with('my-app')
    end

    it { should be_a Rally::Services::Heroku::App }
  end
end
