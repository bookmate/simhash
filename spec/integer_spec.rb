require 'spec_helper'

describe Integer do
  describe "#hamming_distance" do
    it "is zero for the same number" do
      expect( 2.hamming_distance_to(2) ).to eq(0)
    end

    it "is one for single-bit different numbers" do
      expect( 2.hamming_distance_to(3) ).to eq(1)
    end

    it "also works for these numbers" do
      expect( 255.hamming_distance_to(197) ).to eq(4)
    end
  end
end
