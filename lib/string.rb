class String
  def simhash(options={})
    split_by = options.delete(:split_by) || " "
    Simhash.hash(self.split(split_by), options)
  end
  
  # def hash_wl(length)
  #   return 0 if self == ""
  #   puts "RUBY"
  #   x = self[0] << 7
  #   m = 1000003
  #   mask = (1<<length) - 1
  #   self.each_byte{ |char| x = ((x * m) ^ char) & mask }
  #     
  #   x ^= self.size
  #   x = -2 if x == -1
  #   x
  # end

end