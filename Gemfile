source 'https://rubygems.org'

ruby '2.3.1'
gem 'dotenv-rails', :groups => [:development, :test]
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use pg as the database for Active Record
gem 'pg'
gem 'haml-rails'
gem "omniauth-github", '1.1.2'
gem 'github-watcher', github: "sbusso/github-watcher"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'thin'
gem 'dalli'
gem 'whenever', :require => false
gem 'rails_12factor', group: :production

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler', require: false
  gem 'guard-rails'
  gem 'guard-rake'
  gem 'spring'
  gem 'ruby_gntp'
end

