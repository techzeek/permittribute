require 'permittribute/permittributes'

module Permittribute
  class Attrs
    include ::Permittributes

    @@attributes_group_by_roles = {}
    @@defined_meth_names = Hash.new {|k,v| k[v] = []}

    class << self
      def all
        @@defined_meth_names.values.flatten
      end

      def configure_with_role(role, &block)
        @@attributes_group_by_roles[role] ||= OpenStruct.new

        yield @@attributes_group_by_roles[role]

        define_role_attribute_methods(role)
        @@defined_meth_names[role].uniq!
      end

      def define_role_attribute_methods(role)
        @@attributes_group_by_roles[role].each_pair do |attribute, params|
          define_role_attribute_method(role, attribute, params)
        end
      end

      def define_role_attribute_method(role, attribute, params)
        meth_name = (role == :default ? attribute : "#{role}_#{attribute}").to_sym
        define_singleton_method meth_name do
          @@attributes_group_by_roles[role].send(attribute.to_sym)
        end

        @@defined_meth_names[role] << meth_name
      end
    end

  end
end