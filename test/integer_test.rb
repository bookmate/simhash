require 'test/helper'

class SimhashIntegerTest < Test::Unit::TestCase
  def test_hamming_distance
    assert_equal 2.hamming_distance_to(2), 0
    assert_equal 2.hamming_distance_to(3), 1
    assert_equal 255.hamming_distance_to(197), 4    
  end
end
