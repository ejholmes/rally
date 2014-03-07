Then(/^I should have a heroku app called "(.*?)"$/) do |app|
  provider = Rally::Providers::Heroku.new
  response = provider.connection.get "/apps/#{app}"
  expect(response.status).to eq 200
end
