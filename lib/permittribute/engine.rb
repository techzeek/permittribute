module Permittribute
  class Engine < ::Rails::Engine

    engine_name "permittribute"

    initializer 'permittribute.add_strong_params' do |app|
      ActiveSupport.on_load :action_controller do
        include Permittribute::StrongParams
      end
    end

    initializer "permittribute.configure", group: :all do |app|
      Dir[Rails.root.join('lib', 'permittribute/*.rb').to_s].each do |c|
        app.config.to_prepare do
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
    end
  end
end