# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ereignishorizont/client'

Gem::Specification.new do |spec|
  spec.name          = "ereignishorizont-client"
  spec.version       = Ereignishorizont::Client::VERSION
  spec.authors       = ["Susanne Dewein", "Tam Eastley", "Carsten Zimmermann"]
  spec.email         = ["susanne.dewein@gmail.com", "tam.eastley@gmail.com", "cz@aegisnet.de"]
  spec.description   = %q{Ruby client library to connect to ereignishorizont app}
  spec.summary       = %q{Ruby client library to connect to ereignishorizont app}
  spec.homepage      = "https://github.com/Absolventa/ereignishorizont-client"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.1'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"
end
