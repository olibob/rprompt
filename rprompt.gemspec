# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rprompt/version'

Gem::Specification.new do |spec|
  spec.name          = "rprompt"
  spec.version       = Rprompt::VERSION
  spec.authors       = ["Olivier Robert"]
  spec.email         = ["robby57@gmail.com"]
  spec.description   = %q{Adds usefull information to your bash prompt, }
  spec.summary       = %q{rprompt}
  spec.homepage      = "https://github.com/olibob/rprompt.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "term-ansicolor"
end
