$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "helena_administration/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "helena_administration"
  s.version     = HelenaAdministration::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of HelenaAdministration."
  s.description = "TODO: Description of HelenaAdministration."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.7"
  s.add_dependency 'breadcrumbs_on_rails', '~> 2.3'

  # Use slim template engine as default
  s.add_dependency 'slim-rails'
  s.add_dependency 'codemirror-rails'
  s.add_dependency 'mongoid', '~> 4.0.0.rc2'
  s.add_dependency 'mongoid_orderable', '~> 4.1'
  s.add_dependency 'mongoid-simple-tags', '~> 0.1'
  s.add_dependency 'haml-rails', '~> 0.5'
  s.add_dependency 'html5-rails'
  s.add_dependency 'jquery-rails', '~> 3.1'
  s.add_dependency 'sass-rails', '~> 4.0.3' # version needed here http://stackoverflow.com/questions/22392862/undefined-method-environment-for-nilnilclass-when-importing-bootstrap
  s.add_dependency 'bootstrap-sass', '~> 3.2'
  s.add_dependency 'simple_form', '~> 3.1.0.rc2'
  s.add_dependency 'breadcrumbs_on_rails', '~> 2.3'
  s.add_dependency 'rails-i18n', '~> 4.0'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'

  s.add_development_dependency 'rspec-rails', '~> 3'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1'
  s.add_development_dependency 'factory_girl_rails', '~> 4.4'
  s.add_development_dependency 'database_cleaner', '~> 1.3'
  s.add_development_dependency 'ffaker', '~> 1.23'
  s.add_development_dependency 'capybara', '~> 2.3'

end
