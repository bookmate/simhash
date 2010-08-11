class String
  def simhash(hashbits=128)
    Simhash.new(self.split, hashbits)
  end
  
  # string hash of predefined length
  def hash_wl(length)
    return 0 if self == ""

    x = self[0] << 7
    m = 1000003
    mask = (1<<length) - 1
    self.each_byte{ |char| x = ((x * m) ^ char) & mask }
        
    x ^= self.size
    x = -2 if x == -1
    x
  end
end