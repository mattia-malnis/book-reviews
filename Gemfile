source "https://rubygems.org"
ruby file: ".ruby-version"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Background Jobs [https://github.com/bensheldon/good_job]
gem "good_job", "~> 4.2"

# Pagination gem [https://github.com/ddnexus/pagy]
gem "pagy", "~> 9.0"

# Embed SVG documents in your Rails views and style them with CSS [https://github.com/jamesmartin/inline_svg]
gem "inline_svg", "~> 1.10"

# PostgreSQL’s full text search [https://github.com/Casecommons/pg_search]
gem "pg_search", "~> 2.3", ">= 2.3.7"

# Flexible authentication solution for Rails with Warden [https://github.com/heartcombo/devise]
gem "devise", "~> 4.9"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Lint your ERB or HTML files [https://github.com/Shopify/erb-lint]
  gem "erb_lint", "~> 0.6.0", require: false

  # RSpec Testing [https://github.com/rspec/rspec-rails]
  gem "rspec-rails", "~> 7.0"

  # Brings back `assigns` and `assert_template` to your Rails tests [https://github.com/rails/rails-controller-testing]
  gem "rails-controller-testing", "~> 1.0"

  # Fake data generation [https://github.com/ffaker/ffaker]
  gem "ffaker", "~> 2.23"

  # Rails N+1 queries auto-detection [https://github.com/charkost/prosopite]
  gem "prosopite", "~> 1.4", ">= 1.4.2"

  # Ruby extension to parse, deparse and normalize SQL queries using the PostgreSQL query parser [https://github.com/pganalyze/pg_query]
  gem "pg_query", "~> 5.1"

  # A Ruby gem to load environment variables from `.env` [https://github.com/bkeepers/dotenv]
  gem "dotenv-rails", "~> 3.1", ">= 3.1.2"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  # A library for setting up Ruby objects as test data [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails", "~> 6.4"

  # Simple one-liner tests for common Rails functionality [https://github.com/thoughtbot/shoulda-matchers]
  gem "shoulda-matchers", "~> 6.4"

  # Library for stubbing and setting expectations on HTTP requests in Ruby [https://github.com/bblimke/webmock]
  gem "webmock", "~> 3.23"
end
