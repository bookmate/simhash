require 'test/helper'

class SimhashTest < Test::Unit::TestCase
  def test_hashing
    assert_equal Simhash.hash("In the beginning was the Word".split, :hashbits => 64).to_s, "17960354572464531454"     
  end
  
  def test_hashing_with_stopwords
    # String with stop words should be processed as same string withous stop-words
    assert_equal Simhash.hash("In the beginning was the Word".split, :hashbits => 64, :stop_words => true), Simhash.hash("Word".split, :hashbits => 64)
  end
  
  def test_hashing_with_nonascii_stopwords
    assert_equal Simhash.hash("В начале было Слово".split, :hashbits => 64, :stop_words => true), Simhash.hash("начале Слово".split, :hashbits => 64)
  end 
end
