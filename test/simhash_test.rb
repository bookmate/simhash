require 'test/helper'

class SimhashTest < Test::Unit::TestCase
  def test_hashing
    assert_equal Simhash.hash("In the beginning was the Word".split, :hashbits => 64, :token_min_size => 2).to_s, "17095628911399577086"     
  end
  
  def test_case_insensivity
    assert_equal Simhash.hash("В Начале Было Слово".split), Simhash.hash("в начале было Слово".split)
  end
  
  def test_hashing_with_stopwords
    # String with stop words should be processed as same string withous stop-words
    assert_equal Simhash.hash("In the beginning was the Word".split, :hashbits => 64, :stop_words => true), Simhash.hash("Word".split, :hashbits => 64)
  end
  
  def test_hashing_with_nonascii_stopwords
    assert_equal Simhash.hash("В начале было Слово".split, :hashbits => 64, :stop_words => true), Simhash.hash("начале Слово".split, :hashbits => 64)
  end 
end
