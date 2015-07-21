# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edudata/version'

Gem::Specification.new do |spec|
  spec.name          = "edudata"
  spec.version       = Edudata::VERSION
  spec.authors       = ["Juan Gesino"]
  spec.email         = ["jgesino@educatea.com.ar"]
  spec.summary       = %q{Gem to communicate with EduData}
  spec.description   = %q{Simple Ruby wrapper that makes it easier to send data to EduData}
  spec.homepage      = "http://data.educatea.com.ar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
