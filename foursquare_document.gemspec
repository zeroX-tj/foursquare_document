# -*- encoding: utf-8 -*-
require File.expand_path('../lib/foursquare_document/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Niels V"]
  gem.email         = ["nvdk@arguslabs.be"]
  gem.description   = "Easily add foursquare venue information to any mongoid document."
  gem.summary       = "Embed foursquare venue information to any mongoid document."
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "foursquare_document"
  gem.require_paths = ["lib"]
  gem.version       = FoursquareDocument::VERSION
  gem.add_runtime_dependency "mongoid",  "~> 3.0.0"
  gem.add_runtime_dependency 'foursquare2'
end
