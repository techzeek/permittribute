module Permittribute
  class Engine < ::Rails::Engine

    engine_name "permittribute"

    initializer 'permittribute.add_strong_params' do |app|
      ActiveSupport.on_load :action_controller do
        include Permittribute::StrongParams
      end
    end

    initializer "permittribute.configure", group: :all do |app|
      app_config = Rails.root.join('lib', 'permittributes.rb').to_s
      if File.exist?( app_config )
        app.config.to_prepare do
          Rails.configuration.cache_classes ? require(app_config) : load(app_config)
        end
      end
    end
  end
end