# -*- encoding: utf-8 -*-
require File.expand_path('../lib/herhaal/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Teodor Pripoae", "Alexandru Tache"]
  gem.email         = ["toni@netbaiji.com", "hadesgames@netbaiji.com"]
  gem.description   = %q{Easy deploy a web application to a new server}
  gem.summary       = %q{Easy deploy a web application to a new server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "herhaal"
  gem.require_paths = ["lib"]
  gem.version       = Herhaal::VERSION
  
  gem.add_dependency 'thor',  ['>= 0.15.4', '< 2']
  gem.add_dependency 'net-ssh'

  gem.add_development_dependency "rspec", "2.11"
  gem.add_development_dependency "growl"
  gem.add_development_dependency "autotest"
  gem.add_development_dependency "autotest-growl"
  gem.add_development_dependency "vagrant"
end
