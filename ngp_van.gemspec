# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ngp_van/version'

Gem::Specification.new do |spec|
  spec.authors = ['Christopher Styles']
  spec.description = 'An unofficial Ruby wrapper for the NGP VAN API'
  spec.email = ['christopherstyles@gmail.com', 'nathan@daisychain.app']
  spec.files = `git ls-files lib spec README.md`.split($INPUT_RECORD_SEPARATOR)
  spec.homepage = 'https://github.com/christopherstyles/ngp_van'
  spec.licenses = ['MIT']
  spec.name = 'ngp_van'
  spec.platform = Gem::Platform::RUBY
  spec.require_paths = %w[lib]
  spec.required_ruby_version = '>= 3.0.0'
  spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')
  spec.summary = 'Ruby wrapper for the NGP VAN API'
  spec.version = NgpVan::VERSION.dup

  spec.add_dependency 'faraday', '>= 2.0.1', '< 3.0'
end
