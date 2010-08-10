require 'test/helper'

class SimhashStringTest < Test::Unit::TestCase
  def test_string_method
    assert_equal "In the beginning was the Word".simhash(64).to_s, "17960354572464531454"     
  end
end
