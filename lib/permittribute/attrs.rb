require 'permittribute/permittributes'

module Permittribute
  class Attrs
    include ::Permittributes

    def self.all
      class_variables.map do |class_var|
        :"#{class_var.to_s.gsub!('@@', '')}"
      end
    end

    mattr_reader *self.all

    def self.method_missing(method_name, *args, &block)
      class_var = :"@@#{method_name}"
      if class_variables.include?(class_var)
        all << method_name
        self.class.send :define_method, method_name do
          class_variable_get(class_var)
        end
        send(method_name)
      else
        super
      end
    end

  end
end