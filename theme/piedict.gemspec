# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "piedict"
  spec.version       = "0.1.0"
  spec.authors       = ["Marc Riera Casals"]
  spec.email         = ["mrc2407@gmail.com"]

  spec.summary       = "Custom theme."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README|_config\.yml)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.2"
end
