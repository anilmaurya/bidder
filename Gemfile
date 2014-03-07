#source 'https://rubygems.org'
source 'https://rubygems.org'

ruby "2.1.0"
gem 'rails', '4.0.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid', github: 'mongoid/mongoid'
gem 'pusher'
gem 'devise', '3.1.0'
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem 'cancan'
gem 'simple_form'
gem 'bootstrap-sass', '~> 2.3.0.1'
gem 'newrelic_rpm'
gem 'websocket-rails'
gem 'protected_attributes'

gem 'bson'
gem 'moped', github: "mongoid/moped"
gem 'omniauth'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem "github_api"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

#gem "therubyracer"
# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails'#,   '~> 4.0.0'
gem 'coffee-rails'#, '~> 4.0.0'
gem "less-rails"#, '~> 2.3.1' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'less-rails-bootstrap', github: 'metaskills/less-rails-bootstrap', ref: 'cbe20d4593e21297f7bc3bc6bc6471a7ad18e890'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'rails_12factor', group: [:production]

gem 'uglifier'#, '>= 1.0.3'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'#, github: 'carrierwaveuploader/carrierwave-mongoid'
gem 'mongoid-grid_fs', github: 'ahoward/mongoid-grid_fs'
gem "jquery-fileupload-rails"
gem 'capistrano', '~> 2.15'
gem 'quiet_assets', group: :development

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Gemfile
group :test do
  gem 'minitest-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'm'
  gem 'mocha'
  gem 'minitest-metadata'
  gem 'minitest-implicit-subject'
  gem 'minitest-spec-expect'
  gem 'minitest-rails-capybara'
end
