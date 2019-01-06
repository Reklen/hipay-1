Gem::Specification.new do |spec|
  spec.name          = 'hipay'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = ['itkin', 'Arpsara']
  spec.email         = ['nicolas.papon@gmail.com', 'contact@ct2c.fr']

  spec.summary       = 'Hipay client.'
  spec.description   = 'Hipay client.'
  spec.homepage      = 'https://github.com/Paymium/hipay'
  spec.license       = 'MIT'

  spec.files         =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'savon'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'

  spec.add_development_dependency('webmock')
  spec.add_development_dependency('vcr')
end
