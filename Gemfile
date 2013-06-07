source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'rails-api'
gem 'pg'
gem 'active_model_serializers'

group :development do
  gem 'guard-rspec'
  gem 'ruby_gntp' if ENV['USE_GUARD_RUBY_GNTP']
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'pry'
end

group :test do
  gem 'webmock', '~> 1.11'
end
