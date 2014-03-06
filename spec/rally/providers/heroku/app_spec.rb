require 'spec_helper'

describe Rally::Providers::Heroku::App do
  let(:provider) { double(Rally::Providers::Heroku, base_url: 'https://api.heroku.com') }
  subject(:app) { described_class.new(provider) }

  describe '#init' do
    let(:name) { 'my-app' }

    context 'when the app does not exist' do
      before do
        stub_request(:get, "#{provider.base_url}/apps/#{name}").to_return(status: 404)
      end

      context 'when creation succeeds' do
        before do
          stub_request(:post, "#{provider.base_url}/apps").to_return(status: 201, body: { name: name, id: '1234' }.to_json)
          app.init(name)
        end

        its(:id) { should eq '1234' }
      end

      context 'when creation fails' do
      end
    end

    context 'when the app exists' do
      before do
        stub_request(:get, "#{provider.base_url}/apps/#{name}").to_return(status: 200, body: { name: name, id: '1234' }.to_json)
        app.init(name)
      end

      its(:id) { should eq '1234' }
    end
  end

  describe '#drain' do
    let(:app_id) { '1234' }
    let(:url) { 'https://foobar.com' }

    before do
      app.stub(id: app_id)
    end

    context 'when the drain exists' do
      before do
        stub_request(:get, "#{provider.base_url}/apps/#{app_id}/log-drains").to_return(status: 200, body: [ { url: url } ].to_json)
      end

      it 'does nothing' do
        app.drain(url)
      end
    end

    context 'when the drain does not exist' do
      before do
        stub_request(:get, "#{provider.base_url}/apps/#{app_id}/log-drains").to_return(status: 200, body: [].to_json)
      end

      it 'creates the drain' do
        stub_request(:post, "#{provider.base_url}/apps/1234/log-drains").to_return(status: 201)
        app.drain(url)
      end
    end
  end
end
