require "permittribute/version"
require 'permittribute/strong_params'

require 'permittribute/engine'  if defined?(Rails)

module Permittribute
  def self.configure(role=:default, &block)
    Permittribute::Attrs.configure_with_role(role.to_sym, &block)

    Permittribute::StrongParams.delegate *Permittribute::Attrs.defined_meth_names_for_role(role),
        to: :permittribute, prefix: :permittribute
  end
end
