require 'spec_helper'

describe Rally::Providers::Heroku do
  subject(:provider) { described_class.new }

  describe '#app' do
    subject(:app) { provider.app('my-app') }

    before do
      Rally::Providers::Heroku::App.any_instance.stub(:init).with('my-app')
    end

    it { should be_a Rally::Providers::Heroku::App }
  end
end
