module Permittribute
  class Attrs
    @@attributes_group_by_roles = {}
    @@defined_meth_names = Hash.new {|k,v| k[v] = []}

    class << self
      def all
        @@defined_meth_names.values.flatten
      end

      def defined_meth_names_for_role(role)
        @@defined_meth_names[role] || []
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
        unless respond_to? meth_name
          instance_eval <<-eometh
            def #{meth_name}
              @@attributes_group_by_roles['#{role}'.to_sym].send('#{attribute}'.to_sym)
            end
          eometh

          @@defined_meth_names[role] << meth_name
        end
      end
    end

  end
end