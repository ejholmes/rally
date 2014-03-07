require 'spec_helper'

describe Rally::ProviderConfiguration do
  describe '.load' do
    def load_config(fixture)
      Rally::ProviderConfiguration.load(File.expand_path("../../fixtures/provider_configurations/#{fixture}.yml", __FILE__))
    end

    it 'loads configuration files without erb' do
      config = load_config(:simple)

      expect(config.heroku.username).to eq 'foo'
      expect(config.heroku.password).to eq 'bar'
    end

    it 'loads configuration files with erb' do
      ENV['HEROKU_USERNAME'] = 'foo'
      ENV['HEROKU_PASSWORD'] = 'bar'

      config = load_config(:erb)

      expect(config.heroku.username).to eq 'foo'
      expect(config.heroku.password).to eq 'bar'

      ENV.delete 'HEROKU_USERNAME'
      ENV.delete 'HEROKU_PASSWORD'
    end
  end
end
