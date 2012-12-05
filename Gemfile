source 'https://rubygems.org'

# Specify your gem's dependencies in herhaal.gemspec
gemspec

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
 
  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent'
    gem 'growl' # also install growlnotify from the Extras/growlnotify/growlnotify.pkg in Growl disk image
  end
end

gem 'net-ssh'
gem 'thor'