require "spec_helper"

Player = GoFish::Player

RSpec.describe Player do

  subject { Player.new("Test Player") }

  describe "attributes" do
    it "has a name" do
      expect(subject.name).to be_a String
    end
    it "has a secret hand" do
      expect(subject.secret_hand).to be_a RubyCards::Hand
    end
    it "has a table (displayed) hand" do
      expect(subject.table_hand).to be_a RubyCards::Hand
    end
  end

  describe "#initialize" do
    it "requires the Player's name" do
      expect{Player.new}.to raise_error(ArgumentError)
      expect(subject.name).to be_a String
    end
  end

  describe "#secret_hand_empty?" do
    it "returns true if their secret hand is empty" do
      expect(subject.secret_hand_empty?).to be true
    end
    it "returns false if their secret hand isn't empty" do
      subject.draw_five_cards
      expect(subject.secret_hand_empty?).to be false
    end
  end
end
