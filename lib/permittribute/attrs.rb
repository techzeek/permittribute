require 'permittribute/permittributes'

module Permittribute
  class Attrs
    include ::Permittributes

    @@group_by_roles = { }
    @@role_attributes = []

    class << self
      def all
        @@role_attributes
      end

      def configure_with_role(role, &block)
        @@role_attributes = []

        @@group_by_roles[role] = OpenStruct.new

        yield @@group_by_roles[role]

        define_all_attribute_methods
        @@role_attributes.uniq!
      end

      def define_all_attribute_methods
        @@group_by_roles.each do |role, attributes|
          attributes.each_pair do |attribute, params|
            define_role_attribute_method(role, attribute, params)
          end
        end
      end

      def define_role_attribute_method(role, attribute, params)
        meth_name = "#{role}_#{attribute}".to_sym
        define_singleton_method meth_name do
          params
        end
        @@role_attributes << meth_name
      end
    end

  end
end