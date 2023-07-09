require 'rubygems'

Gem::Specification.new do |spec|
  spec.name = "firebird_connector"
  spec.version = "1.0.0"
  spec.date = "2023-07-06"
  spec.summary = "Firebird database connector for Ruby."
  spec.description = "Ruby Firebird Extension Library"
  spec.licenses = ["Nonstandard"]
  spec.requirements = "Firebird client library fbclient.dll, libfbclient.so or Firebird.framework."
  spec.require_path = '.'
  spec.author = "Bruno Pegoraro"
  spec.email = "brunopegoraro@intelitech.com.br"
  spec.homepage = "https://github.com/intelitechub/rubygem_firebird"
  spec.extra_rdoc_files = ['README']
  spec.files = ['extconf.rb', 'fb.c', 'README', 'firebird_extensions.rb']
  spec.platform = case RUBY_PLATFORM
    when /win32/ then Gem::Platform::WIN32
  else
    Gem::Platform::RUBY
  end
  spec.extensions = ['extconf.rb'] if spec.platform == Gem::Platform::RUBY
end