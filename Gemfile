source 'https://rubygems.org'

git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
    "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'

# sqlite3
gem 'sqlite3'

#respond_to docx
gem 'responders'
# Ruby Html to word Gem
gem 'htmltoword', '~> 0.5.1'

# A PDF generation plugin for Ruby on Rails
gem 'wicked_pdf'

# The simplest way to install all of the binaries (Linux, OSX, Windows)
gem 'wkhtmltopdf-binary'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

#SQLite3 to MySQL
#gem 'yaml_db'

#MySQL 
#gem 'mysql2'

# Let's encrypt plugin for Ruby on Rails applications
gem 'letsencrypt_plugin'

# Integration of TinyMCE with the Rails asset pipeline
gem 'tinymce-rails'

# Twitter Bootstrap for Rails 3.x - 4 Asset Pipeline
gem "twitter-bootstrap-rails"

#Paginate
gem 'will_paginate',           '3.1.0'
gem 'bootstrap-will_paginate', '0.0.10'

# Locale data for Ruby on Rails I18n
gem 'rails-i18n', '~> 5.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platform: :mri
end

group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
