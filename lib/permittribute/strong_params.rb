require 'permittribute/attrs'

module Permittribute
  module StrongParams
    def permittribute
      p "_"*80
      p Permittribute::Attrs.authors
      Permittribute::Attrs
    end
  end
end
