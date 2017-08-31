# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mini_flow/version'

Gem::Specification.new do |spec|
  spec.name          = 'miniflowrb'
  spec.version       = MiniFlowRb::VERSION
  spec.authors       = ["Oliver Valls"]
  spec.email         = ['tramuntanal@gmail.com']

  spec.summary       = %q{Basic TensorFlow version in Ruby.}
  spec.description   = %q{Basic TensorFlow version in Ruby to learn two concepts
  at the heart of neural networks - backpropagation and differentiable graphs.}
  spec.homepage      = 'https://www.linkedin.com/in/olivervalls'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'daru'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
