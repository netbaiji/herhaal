require "herhaal/version"

module Herhaal
  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'herhaal')
  SYSTEM_PACKAGES_PATH = File.join(LIBRARY_PATH, 'system_packages')
  LANGUAGE_LIBRARIES_PATH = File.join(LIBRARY_PATH, 'language_libraries')
  DATABASES_PATH = File.join(LIBRARY_PATH, 'databases')
  SERVERS_PATH = File.join(LIBRARY_PATH, 'servers')
  
  module SystemPackages
    autoload :Base,         File.join(SYSTEM_PACKAGES_PATH, 'base')
    autoload :Ubuntu,       File.join(SYSTEM_PACKAGES_PATH, 'ubuntu')
  end
  
  %w{
    errors
    model
  }.each{|lib| require File.join(LIBRARY_PATH, lib)}
end
