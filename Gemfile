source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.7.1'
gem 'rails-api'
gem 'settingslogic'
gem 'mysql2'
gem 'omniauth-uaa-oauth2', github: 'cloudfoundry/omniauth-uaa-oauth2'
gem 'nats'
gem 'sass-rails'
gem 'eventmachine', '~> 1.0.7'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'test-unit'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'brakeman'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'webmock'
end
