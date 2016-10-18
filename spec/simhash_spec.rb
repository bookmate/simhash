# encoding: utf-8
require 'spec_helper'

describe Simhash do
  describe "#hashing" do
    it "generates expected result" do
      expect(
        Simhash.hash("in the beginning was the word".split, :hashbits => 64, :token_min_size => 2).to_s
      ).to eq("17095628911399577086")
    end

    it "also works with this stuff" do
      expect(
        Simhash.hash("in the beginning was the word".split(/./), :hashbits => 64, :token_min_size => 2).to_s
      ).to eq("18446744073709551615")
    end
  end
end
