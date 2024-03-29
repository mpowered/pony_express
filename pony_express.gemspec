$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pony_express/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pony_express"
  s.version     = PonyExpress::VERSION
  s.authors     = ["Gary Greyling"]
  s.email       = ["greyling.gary@gmail.com"]
  s.homepage    = "http://github.com/mpowered/pony_express"
  s.summary     = "Lightweight HTTP message bus"
  s.description = "Message bus add-on for Rails applications"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", '>= 3.2.22.5'
  s.add_dependency "httparty", '>= 0.11.0'
  s.add_dependency "sidekiq", '~> 4'

  s.add_development_dependency "sqlite3"
end
