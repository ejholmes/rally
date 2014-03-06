require 'spec_helper'

describe Rally::Services::Heroku::App do
  let(:service) { double(Rally::Services::Heroku, base_url: 'https://api.heroku.com') }
  subject(:app) { described_class.new(service) }

  describe '#init' do
    let(:name) { 'my-app' }

    context 'when the app does not exist' do
      before do
        stub_request(:get, "#{service.base_url}/apps/#{name}").to_return(status: 404)
      end

      context 'when creation succeeds' do
        before do
          stub_request(:post, "#{service.base_url}/apps").to_return(status: 201, body: { name: name, id: '1234' }.to_json)
          app.init(name)
        end

        its(:id) { should eq '1234' }
      end

      context 'when creation fails' do
      end
    end

    context 'when the app exists' do
      before do
        stub_request(:get, "#{service.base_url}/apps/#{name}").to_return(status: 200, body: { name: name, id: '1234' }.to_json)
        app.init(name)
      end

      its(:id) { should eq '1234' }
    end
  end
end
