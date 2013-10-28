require 'pry'
class StringHasher
  attr_reader :length

  def initialize(length)
    @length = length
  end

  def hash(string)
    if String.public_instance_methods.include?("hash_vl")
      c_hash(string)
    else
      ruby_hash(string)
    end
  end

  def c_hash(string)
    string.hash_vl(length)
  end

  def ruby_hash(string)
    return 0 if string == ""

    x = string.bytes.first << 7
    m = 1000003
    mask = (1<<length) - 1
    string.each_byte{ |char| x = ((x * m) ^ char.to_i) & mask }

    x ^= string.bytes.count
    x = -2 if x == -1
    x.to_s
  end
end
