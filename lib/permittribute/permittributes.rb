module Permittributes
  def self.configure(&block)
    Permittribute::Attrs.class_eval do
      instance_eval(&block)
    end

    Permittribute::StrongParams.delegate *Permittribute::Attrs.all, to: :permittribute, prefix: :permittribute
  end
end
