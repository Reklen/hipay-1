Gem::Specification.new do |spec|
  spec.name          = 'hipay'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = ['itkin']
  spec.email         = ['nicolas.papon@gmail.com']

  spec.summary       = 'Hipay client.'
  spec.description   = 'Hipay client.'
  spec.homepage      = 'https://github.com/Paymium/hipay'
  spec.license       = 'MIT'

  spec.files         =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'savon',                  '~> 2.11.1'

  spec.add_development_dependency 'bundler',    '~> 1.10'
  spec.add_development_dependency 'rake',       '~> 10.4'
  spec.add_development_dependency 'yard',       '~> 0.8'
  spec.add_development_dependency 'simplecov',  '~> 0.10'
  spec.add_development_dependency 'rubocop',    '~> 0.32'
  spec.add_development_dependency 'pry',        '~> 0.10.1'
end
