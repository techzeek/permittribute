# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'permittribute/version'

Gem::Specification.new do |spec|
  spec.name          = "permittribute"
  spec.version       = Permittribute::VERSION
  spec.authors       = ["Priyank Gupta"]
  spec.email         = ["priyankgupta1988@gmail.com", "priyankgupta1988@yahoo.com"]
  spec.summary       = %q{ Reuse Permitted Attributes and group them at a single reference file }
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
