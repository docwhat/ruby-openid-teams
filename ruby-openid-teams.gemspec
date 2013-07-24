# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openid/extensions/teams/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-openid-teams"
  spec.version       = OpenID::Teams::VERSION
  spec.authors       = ["Christian Höltje"]
  spec.email         = ["docwhat@gerf.org"]
  spec.description   = %q{Support for the OpenIDTeams extension}
  spec.summary       = %q{Adds support for the OpenIDTeams extension (from LaunchPad.net) to ruby-openid}
  spec.homepage      = "https://github.com/docwhat/ruby-openid-teams"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "ruby-openid",             "~> 2.2"

  spec.add_development_dependency "bundler",                 "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",                   "~> 2.14"

  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "rb-inotify"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "growl"
  spec.add_development_dependency "libnotify"
  spec.add_development_dependency "terminal-notifier-guard"
end
