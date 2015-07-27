module Permittributes
  def self.configure(role=:default, &block)
    Permittribute::Attrs.configure_with_role(role.to_sym, &block)

    Permittribute::StrongParams.delegate *Permittribute::Attrs.all, to: :permittribute, prefix: :permittribute
  end
end
