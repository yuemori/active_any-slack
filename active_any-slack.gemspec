# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_any/slack/version"

Gem::Specification.new do |spec|
  spec.name          = "active_any-slack"
  spec.version       = ActiveAny::Slack::VERSION
  spec.authors       = ["yuemori"]
  spec.email         = ["yuemori@aiming-inc.com"]

  spec.summary       = %q{A Slack client implemented by active_any}
  spec.description   = %q{A Slack client implemented by active_any.}
  spec.homepage      = "https://github.com/yuemori/active_any"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "active_any"
  spec.add_dependency "slack-ruby-client"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "guard-rubocop"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-coolline"
  spec.add_development_dependency "pry-inline"
  spec.add_development_dependency "pry-state"
end
