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
    tokens.each do |token|
      hashed_token = self.string_hash(token)
      bitmask = 0
      self.hashbits.times do |i|
        bitmask = 1 << i
        v[i] += (hashed_token & bitmask).zero? ? -1 : +1
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
      mask = 2**self.hashbits - 1
      string.each_byte{ |char| x = ((x * m) ^ char) & mask }
          
      x ^= string.size
      x = -2 if x == -1
      x
    end
  end
end