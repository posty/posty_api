source 'http://rubygems.org'

gem 'rack'
gem 'rake'
gem 'grape'
gem 'grape-swagger'
gem 'activerecord', '~> 3.2.22', require: 'active_record'
gem 'json'
gem 'rack-cors', require: 'rack/cors'
gem 'schema_plus'

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
  gem 'mysql2'
end

group :postgresql, optional: true do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end
