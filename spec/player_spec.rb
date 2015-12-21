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

  describe "#ask_for_card" do
    before :each do
      subject.draw_five_cards
    end

    context "when asking a non-existant player" do
      it "returns nil" do
        expect(subject.ask_for_card("Non-existant", RubyCards::Card.new)).to be_nil
      end
    end

    context "when asking another player" do
      let(:p2) { p2 = Player.new("Test Player 2") }

      it "returns nil if we do not have this card" do
        card = RubyCards::Card.new(2, 'Club')
        while subject.secret_hand.cards.include? card
          card = RubyCards::Card.new(card.rank + 1, 'Club')
        end

        expect(subject.ask_for_card("Test Player 2", card)).to be_nil
      end

      context "and that player has this card" do
        it "returns true" do
        end
      end

      context "and that player doesn't have this card" do
        it "returns false if we do not fish the card" do
        end
        it "returns true if we DO fish this card" do
        end
      end
    end
  end
end
