# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'windows_server_info/version'

Gem::Specification.new do |spec|
  spec.name          = 'windows_server_info'
  spec.version       = WindowsServerInfo::VERSION
  spec.authors       = ['Jonathan Morley']
  spec.email         = ['morley.jonathan@gmail.com']

  spec.summary       = 'Windows Server Information.'
  spec.description   = 'Get information on windows servers over WinRM and compare them for differences.'

  spec.files         = Dir['{bin,lib,exe}/**/*', 'README*', 'LICENSE*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_dependency 'colorize'
  spec.add_dependency 'hashdiff'
  spec.add_dependency 'nori'
  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_dependency 'winrm'
end
