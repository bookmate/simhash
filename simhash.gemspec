require 'rake/extensiontask'

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

include_files = ["README*", "LICENSE", "Rakefile", "init.rb", "{lib,rails,ext}/**/*"].map do |glob|
  Dir[glob]
end.flatten
exclude_files = ["**/*.o", "**/*.bundle", "**/Makefile", "*.bundle" ].map do |glob|
  Dir[glob]
end.flatten

spec = Gem::Specification.new do |s|
  s.name              = "simhash"
  s.version           = "0.1.0"
  s.author            = "Alex Gusev"
  s.email             = "alex.gusev@bookmate.ru"
  s.homepage          = "http://github.com/bookmate/simhash"
  s.rubyforge_project = "simhash"
  s.description       = "Implementation of Charikar simhashes in Ruby"
  s.platform          = Gem::Platform::RUBY
  s.summary           = "Gives you possbility to convert string into simhashes to futher use: finding near-duplicates, similar strings, etc."
  s.files             = include_files - exclude_files
  s.require_path      = "lib"
  s.test_files        = Dir["test/**/test_*.rb"]
  s.extensions        = ["ext/string_hashing/extconf.rb"] 
end

Rake::GemPackageTask.new(spec) do |pkg|

end

Rake::ExtensionTask.new('string_hashing', spec)
