require 'rails/generators'
module Permittribute
  class InstallGenerator < Rails::Generators::Base
    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def configure_application
      application <<-APP

    config.eager_load_paths += ["\#{Rails.root}/lib"]
      APP
    end

    def generate_config
      template "permittributes.rb", "lib/permittributes.rb"
    end
  end
end