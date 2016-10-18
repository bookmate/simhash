require 'rubygems'
require 'rspec'
require 'unicode'

require_relative "../lib/simhash"
require_relative "../lib/string_hasher"
require_relative "../lib/integer"

begin
  require_relative "../string_hashing" 
rescue LoadError
  nil
end
