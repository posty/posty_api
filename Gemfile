source 'http://rubygems.org'

gem 'rack', '~> 1.5.2'
gem 'rake', '~> 10.3.2'
gem 'grape', '~> 0.7.0'
gem 'grape-swagger'
gem 'activerecord', '~> 3.2.22', require: 'active_record'
gem 'json'
gem 'rack-cors', require: 'rack/cors'
gem 'schema_plus', '~> 1.5.1'

group :test, :development do
  gem 'shotgun'
  gem 'racksh'
  gem 'rubocop'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
end

group :mysql, optional: true do
  gem 'mysql2', '~> 0.3.16'
end

group :postgresql, optional: true do
  gem 'pg', '~> 0.18.4'
  gem 'activerecord-postgresql-adapter'
end
