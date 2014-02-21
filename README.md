# Rally

Are you constantly setting up papertrail drains, adding labs features to heroku
apps, configuring service hooks in github, and doing all kinds of boring tasks with third
party services? Then Rally is for you!

Rally is a DSL and REST API for tying services together. Think of it as Chef for third
party apis. It can:

* Create papertrail systems.
* Create honeybadger projects.
* Create heroku apps.
* Configure webhooks/labs features on heroku apps.
* Create github repos.
* Configure services in github.

## Usage

Configure your services:

```yaml
heroku:
  api_key: <%= ENV['HEROKU_API_KEY'] %>
  hooks:
    hipchat:
      auth_token: <%= ENV['HIPCHAT_TOKEN'] %>
      room: "Cat Facts"
github:
  api_key: <%= ENV['GITHUB_API_KEY'] %>
  services:
    travis:
      user: neck@beard.com
      token: <%= ENV['TRAVIS_TOKEN'] %>
    hipchat:
      token: <%= ENV['HIPCHAT_TOKEN'] %>
      room: "Cat Facts"
```

Add a recipie:

```ruby
# recipies/default.rb

%W[r101-#{name} r101-#{name}-staging].each do |name|
  heroku.app name do |app|
    app.hook :hipchat

    app.drain papertrail.system(name).to_url

    app.labs :user_env_compile, :log_runtime_metrics, :http_request_id

    app.addons :newrelic
  end
end

github.repo "remind101/r101-#{name}" do |repo|
  repo.services :hipchat, :travis
end

honeybadger.project(name)
```

Setup a new app:

```bash
curl -d '{"name":"dashboard"}' http://rally.herokuapp.com/api/app
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
