require 'vcr'
require 'webmock/cucumber'

VCR.configure do |config|
  config.cassette_library_dir = 'features/cassettes'
  config.default_cassette_options = {
    match_requests_on: [:method, :uri, :body],
    record: ENV['CI'] ? :none : :new_episodes,
    decode_compressed_response: true,
    allow_playback_repeats: true,
    erb: true
  }
  config.hook_into :webmock
  config.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
