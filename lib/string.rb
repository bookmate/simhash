class String
  def simhash(hashbits=512)
    Simhash.new(self.split, hashbits)
  end
end