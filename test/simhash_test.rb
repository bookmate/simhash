require 'test/helper'

class SimhashTest < Test::Unit::TestCase
  def test_hashing
    assert_equal Simhash.new("In the beginning was the Word".split, 64).to_s, "17960354572464531454"     
  end
end
