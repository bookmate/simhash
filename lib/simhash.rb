# encoding: utf-8

require 'active_support/core_ext/string/multibyte'
require 'unicode'

require 'string'
require 'integer'
require 'simhash/stopwords'

begin
  require 'string_hashing'
rescue LoadError
end

module Simhash  
  DEFAULT_STRING_HASH_METHOD = String.public_instance_methods.include?("hash_vl") ? :hash_vl : :hash_vl_rb
  PUNCTUATION_REGEXP = if RUBY_VERSION >= "1.9"
    /(\s|\d|[^\p{L}]|\302\240| *— *|[«»…\-–—]| )+/u
  else
    /(\s|\d|\W|\302\240| *— *|[«»…\-–—]| )+/u
  end
  
  
  def self.hash(tokens, options={})
    hashbits = options[:hashbits] || 64
    hashing_method = options[:hashing_method] || DEFAULT_STRING_HASH_METHOD
        
    v = [0] * hashbits
    masks = v.dup
    masks.each_with_index {|e, i| masks[i] = (1 << i)}
    
    self.each_filtered_token(tokens, options) do |token|
      hashed_token = token.send(hashing_method, hashbits).to_i
      hashbits.times do |i|
        v[i] += (hashed_token & masks[i]).zero? ? -1 : +1
      end
    end
   
    fingerprint = 0

    hashbits.times { |i| fingerprint += 1 << i if v[i] >= 0 }  
      
    fingerprint    
  end
  
  def self.each_filtered_token(tokens, options={})
    token_min_size = options[:token_min_size].to_i
    stop_sentenses = options[:stop_sentenses]
    tokens.each do |token|
      # cutting punctuation (\302\240 is unbreakable space)
      token = token.gsub(PUNCTUATION_REGEXP, ' ') if !options[:preserve_punctuation]
      
      token = Unicode::downcase(token.strip)
      
      # cutting stop-words
      token = token.split(" ").reject{ |w| Stopwords::ALL.index(" #{w} ") != nil }.join(" ") if options[:stop_words]
    
      # cutting stop-sentenses
      next if stop_sentenses && stop_sentenses.include?(" #{token} ")
            
      next if token.size.zero? || token.mb_chars.size < token_min_size
      
      yield token      
    end
  end
  
  def self.filtered_tokens(tokens, options={})
    filtered_tokens = []
    self.each_filtered_token(tokens, options) { |token| filtered_tokens << token }
    filtered_tokens  
  end
  
  def self.hm
    @@string_hash_method
  end
end