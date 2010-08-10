class String
  def simhash(hashbits=128)
    Simhash.new(self.split, hashbits)
  end
end