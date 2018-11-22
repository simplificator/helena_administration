module HelenaAdministration
  class Engine < ::Rails::Engine
    isolate_namespace HelenaAdministration
    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.assets.precompile += %w[helena_administration.js helena_administration.css]

    # Thre are no decorators at the moment
    # config.to_prepare do
    #   Dir.glob(Rails.root + 'app/decorators/**/*_decorator*.rb').each do |c|
    #     require_dependency c
    #   end
    # end
  end
end
