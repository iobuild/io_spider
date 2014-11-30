# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'io_spider/version'

Gem::Specification.new do |spec|
  spec.name          = "io_spider"
  spec.version       = IoSpider::VERSION
  spec.authors       = ["Arly Xiao"]
  spec.email         = ["arlyxiao@163.com"]
  spec.summary       = %q{The simplest spider tool}
  spec.description   = %q{The simplest spider tool}
  spec.homepage      = "https://github.com/iobuild/io_spider"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec-rails', '~> 2.14.0'
end
