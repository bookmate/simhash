# encoding: utf-8

require 'active_support/core_ext/string/multibyte'
require 'unicode'

require 'string'
require 'integer'
require 'simhash/stopwords'

begin
  require_relative '../ext/string_hashing/string_hashing'
rescue LoadError
end

module Simhash  
  # @param hashbits The number of bits in the resulting hash
  # @param hasher An object which returns a numeric hash when #hash is called with a token
  #
  def self.hash(tokens, options={})
    hashbits = options[:hashbits] || 64
    hasher = options[:hasher] || StringHasher.new(hashbits)
        
    v = [0] * hashbits
    masks = v.dup
    masks.each_with_index {|e, i| masks[i] = (1 << i)}
    
    self.each_token(tokens, options) do |token|
      hashed_token = hasher.hash(token).to_i
      hashbits.times do |i|
        v[i] += (hashed_token & masks[i]).zero? ? -1 : +1
      end
    end
   
    fingerprint = 0

    hashbits.times { |i| fingerprint += 1 << i if v[i] >= 0 }  
      
    fingerprint    
  end
  
  def self.each_token(tokens, options={})
    token_min_size = options[:token_min_size].to_i

    tokens.each do |token|
      next if token.size.zero? || token.mb_chars.size < token_min_size
      
      yield token      
    end
  end
   
  def self.hm
    @@string_hash_method
  end
end
