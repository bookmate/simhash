class Integer
  # Hamming distance – number of different bits in same positions
  # H(1001, 1110) = 3 
  # H(1001, 1000) = 1
  def hamming_distance_to(integer)
    total = 0
    difference = self ^ integer

    while difference > 0 do
      total += 1 if (difference & 1).nonzero?
      difference >>= 1
    end
    
    total
  end
end