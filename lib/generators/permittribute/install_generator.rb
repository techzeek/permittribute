require 'rails/generators'
module Permittribute
  class InstallGenerator < Rails::Generators::Base
    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def configure_application
      application <<-APP

    config.eager_load_paths += ["\#{Rails.root}/lib/permittribute"]
      APP
    end

    def generate_config
      template "default.rb", "lib/permittribute/default.rb"
      template "admin.rb", "lib/permittribute/admin.rb"
      template "api.rb", "lib/permittribute/api.rb"
    end
  end
end