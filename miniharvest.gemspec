# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miniharvest/version'

Gem::Specification.new do |spec|
  spec.name          = "miniharvest"
  spec.version       = MiniHarvest::VERSION
  spec.authors       = ["Jamie Little"]
  spec.email         = ["j.little@miami.edu"]

  spec.summary       = "A Gem to harvest OAI-PMH repositories"
  spec.description   = ""
  spec.homepage      = "https://github.com/little9/miniharvest"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = "miniharvest"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
 
  spec.add_runtime_dependency "nokogiri"
end
