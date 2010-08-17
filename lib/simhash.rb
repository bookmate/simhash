$KCODE = 'u' 
require 'active_support/core_ext/string/multibyte'
require File.join(File.dirname(__FILE__), "simhash", "stopwords")

module Simhash  
  def self.hash(tokens, options={})
    hashbits = options[:hashbits] || 64
    token_min_size = options[:token_min_size].to_i
    
    v = [0] * hashbits
    masks = v.dup
    masks.each_with_index {|e, i| masks[i] = (1 << i)}
    
    tokens.each do |token|
      # cutting punctuation (\302\240 is unbreakable space)
      token = token.gsub(/(\s|\d|\W|\302\240| *— *|[«»\…\-\–\—]| )+/u,' ') if !options[:preserve_punctuation]
      
      token = token.strip.mb_chars.downcase
      
      # cutting stop-words
      token = token.split(" ").reject{ |w| Stopwords::ALL.index(" #{w} ") != nil }.join(" ") if options[:stop_words]
            
      next if token.size.zero? || token.size < token_min_size

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