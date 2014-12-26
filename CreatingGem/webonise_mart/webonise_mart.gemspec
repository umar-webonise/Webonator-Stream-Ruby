require './lib/webonise_mart/version'
Gem::Specification.new do |s|
  s.name        = 'webonise_mart'
  s.version     = WeboniseMart::VERSION
  s.date        = '2014-12-25'
  s.summary     = "Shop invnetory management system"
  s.description = "Simple implementation of inventory management with tow types of users"
  s.authors     = ["Umar Siddiqui"]
  s.email       = 'umar.s@weboniselab.com'
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.executables << 'webonise_mart'
  s.require_paths =["lib"]
  s.homepage    =
    'http://rubygems.org/gems/hola'
  s.license       = 'Webonise'
end