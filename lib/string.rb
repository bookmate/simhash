class String
  def simhash(options={})
    split_by = options.delete(:split_by) || " "
    Simhash.hash(self.split(split_by), options)
  end
  
  def hash_vl_rb(length)
    return 0 if self == ""

    x = self.bytes.first << 7
    m = 1000003
    mask = (1<<length) - 1
    self.each_byte{ |char| x = ((x * m) ^ char.to_i) & mask }

    x ^= self.bytes.count
    x = -2 if x == -1
    x
  end

end