Then(/^I should have a heroku app called "(.*?)"$/) do |app|
  provider = Rally::Providers::Heroku.new
  response = provider.connection.get "/apps/#{app}"
  expect(response.status).to eq 200
end

Then(/^I should have a drain with the url "(.*?)" on the app called "(.*?)"$/) do |url, app|
  provider = Rally::Providers::Heroku.new
  response = provider.connection.get "/apps/#{app}/log-drains"
  expect(response.body.find { |drain| drain['url'] == url }['url']).to eq url
end
