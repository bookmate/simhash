$KCODE = 'u' 
require File.join(File.dirname(__FILE__), "simhash", "stopwords")
require 'string'
require 'integer'
begin
  require 'string_hashing'
rescue LoadError
end

module Simhash  
  DEFAULT_STRING_HASH_METHOD = String.public_instance_methods.include?("hash_wl") ? :hash_wl : :hash_wl_rb
  
  def self.hash(tokens, options={})
    hashbits = options[:hashbits] || 64
    token_min_size = options[:token_min_size].to_i
    hashing_method = options[:hashing_method] || DEFAULT_STRING_HASH_METHOD
    
    v = [0] * hashbits
    masks = v.dup
    masks.each_with_index {|e, i| masks[i] = (1 << i)}
    
    tokens.each do |token|
      # cutting punctuation (\302\240 is unbreakable space)
      token = token.gsub(/(\s|\d|\W|\302\240| *— *|[«»\…\-\–\—]| )+/u,' ') if !options[:preserve_punctuation]
      
      token = Unicode::downcase(token.strip)
      
      # cutting stop-words
      token = token.split(" ").reject{ |w| Stopwords::ALL.index(" #{w} ") != nil }.join(" ") if options[:stop_words]
            
      next if token.size.zero? || token.size < token_min_size
      hashed_token = token.send(hashing_method, hashbits).to_i
      hashbits.times do |i|
        v[i] += (hashed_token & masks[i]).zero? ? -1 : +1
      end
    end
   
    fingerprint = 0

    hashbits.times { |i| fingerprint += 1 << i if v[i] >= 0 }  
      
    fingerprint    
  end
  
  def self.hm
    @@string_hash_method
  end
end