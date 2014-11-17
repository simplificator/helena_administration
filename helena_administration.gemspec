$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'helena_administration/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'helena_administration'
  s.version     = HelenaAdministration::VERSION
  s.authors     = ['Markus Graf']
  s.email       = ['info@markusgraf.ch']
  s.homepage    = 'https://github.com/gurix/helena_administration'
  s.summary     = 'Helena Administration is a simple rails application that provides a user interface to manage apps running with the Helena framework.'
  s.description = 'Helena Administration is a simple rails application that provides a user interface to manage apps running with the Helena framework.'
  s.license     = 'GPL3'

  s.files        = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")

  s.add_dependency 'kaminari'
  s.add_dependency 'rails', '~> 4.1.7'
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
end
