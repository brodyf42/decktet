require_relative 'lib/decktet/version'

Gem::Specification.new do |spec|
  spec.name     = 'decktet'
  spec.version  = Decktet::VERSION
  spec.authors  = ['Brody Fischer']
  spec.email    = ['brodyf42@gmail.com']
  spec.summary  = 'This gem provides an interface to the versatile decktet playing card system.'
  spec.homepage = 'https://github.com/brodyf42/decktet'
  spec.license  = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.add_development_dependency 'rspec'
end
