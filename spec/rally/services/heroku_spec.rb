require 'spec_helper'

describe Rally::Services::Heroku do
  subject(:service) { described_class.new }

  describe '#app' do
    subject { service.app('dashboard') }
    it { should be_a Rally::Services::Heroku::App }
  end
end
