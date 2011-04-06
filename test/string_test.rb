# encoding: utf-8
require './test/helper'

class SimhashStringTest < Test::Unit::TestCase
  def test_string_method
    assert_equal "In the beginning was the Word".simhash(:hashbits => 64).to_s, "17095628911399577086"
  end
  
  def test_parameter_passing
    assert_equal "Я пошел".simhash(:stop_words => true), "пошел".simhash(:stop_words => true)
  end
  
  def test_splitting
    assert_equal "In the".simhash(:split_by => ""), Simhash.hash(["I", "n", " ", "t", "h", "e"])
  end
  
  def test_hashing
    assert_equal "Word".hash_vl(64).to_i, 10958914953375318724
  end
  
  def test_rb_hashing
    assert_equal "В начале".hash_vl(64).to_i, "В начале".hash_vl_rb(64).to_i
    assert_equal "было слово".hash_vl(64).to_i, "было слово".hash_vl_rb(64).to_i
  end

end
