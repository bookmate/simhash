#require 'rubygems'
#require 'lingua/stemmer'
$KCODE = 'u' 
require 'active_support/core_ext/string/multibyte'
require File.join(File.dirname(__FILE__), "simhash", "stopwords")

module Simhash  
  def self.hash(tokens, options={})
    hashbits = options[:hashbits] || 64
    
    v = [0] * hashbits
    masks = v.dup
    masks.each_with_index {|e, i| masks[i] = (1 << i)}
    
    tokens.each do |token|
      token = token.gsub(/(\s|\d|\W)+/u,' ').strip
      
      next if token.size < 2 
      next if options[:stop_words] && Stopwords::ALL.include?(token.strip.mb_chars.downcase)
      
      #token = Lingua.stemmer(token, :language => :ru)
      hashed_token = token.hash_wl(hashbits)
      bitmask = 0
      hashbits.times do |i|
        v[i] += (hashed_token & masks[i]).zero? ? -1 : +1
      end
    end
   
    fingerprint = 0

    hashbits.times { |i| fingerprint += 1 << i if v[i] >= 0 }  
      
    fingerprint    
  end
end