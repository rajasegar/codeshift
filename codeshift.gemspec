lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "codeshift/version"

Gem::Specification.new do |spec|
  spec.name          = "codeshift"
  spec.version       = Codeshift::VERSION
  spec.authors       = ["Rajasegar Chandran"]
  spec.email         = ["rajasegar.c@gmail.com"]

  spec.summary       = %q{A tool to run Ruby codemods.}
  spec.description   = %q{A Ruby CLI to transform source code by converting them to ASTs using the parser gem.}
  spec.homepage      = "https://github.com/rajasegar/codeshift"
  spec.license       = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rajasegar/codeshift"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'parser', '~> 2.6'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
