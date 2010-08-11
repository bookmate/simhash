class Simhash
  attr_accessor :hashbits, :hash
  def initialize(tokens='', hashbits=128)
    self.hashbits = hashbits
    self.hash = self.simhash(tokens)
    hash
  end
  
  def to_s
    self.hash.to_s
  end
  
  def to_i
    self.hash.to_i
  end
  
  def simhash(tokens)
    v = [0] * self.hashbits
    masks = v.dup
    masks.each_with_index {|e, i| masks[i] = (1 << i)}
    tokens.each do |token|
      hashed_token = token.hash_wl(self.hashbits)
      bitmask = 0
      self.hashbits.times do |i|
        v[i] += (hashed_token & masks[i]).zero? ? -1 : +1
      end
    end
   
    fingerprint = 0

    self.hashbits.times { |i| fingerprint += 1 << i if v[i] >= 0 }  
      
    fingerprint    
  end
  
  def hamming_distance(other_hash)
    self.hash.hamming_distance_to(other_hash.hash)
  end

  def string_hash(string)
    if string == ""
      return 0
    else
      x = string[0] << 7
      m = 1000003
      mask = (1<<self.hashbits) - 1
      string.each_byte do |char| 
        x = ((x * m) ^ char) & mask
      end
          
      x ^= string.size
      x = -2 if x == -1
      x
    end
  end
end