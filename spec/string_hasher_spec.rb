# encoding: utf-8
require 'spec_helper'

describe StringHasher do
  let(:hasher) { StringHasher.new(64) }

  describe "#hash" do
    it "returns expected value" do
      expect( hasher.hash("Word") ).to eq('10958914953375318724')
    end
  end

  describe "#c_hash" do
    it "returns expected value" do
      expect( hasher.c_hash("Word") ).to eq('10958914953375318724')
    end
  end

  describe "#ruby_hash" do
    it "returns expected value" do
      expect( hasher.ruby_hash("Word") ).to eq('10958914953375318724')
    end
  end
end
