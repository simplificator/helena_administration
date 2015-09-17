source 'https://rubygems.org'

# Declare your gem's dependencies in helena_administration.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

# gem 'helena', '~> 1.0.0.rc3'
gem 'helena', git: 'https://github.com/gurix/helena.git', branch: 'feature/support-mongoid-5.0'
# gem 'helena', path: '../helena/'

# TODO: remove this after https://github.com/benedikt/mongoid-tree/pull/61 is merged
gem 'mongoid-tree', github: 'gurix/mongoid-tree', branch: 'mongoid-5.0'

gem 'compass-h5bp', group: :assets
group :development, :test do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'pry'
  gem 'simplecov'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'mongoid-rspec'
  gem 'rspec-collection_matchers', '~> 1'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'spork'
  gem 'autotest',            require: false
  gem 'autotest-rails-pure', require: false
  gem 'autotest-fsevent',    require: false
  gem 'autotest-growl',      require: false
  gem 'faker'
  gem 'binding_of_caller'
  gem 'rspec-core'
  gem 'responders', '~> 2.0'
end
