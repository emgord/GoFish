require "spec_helper"

Player = GoFish::Player
Game = GoFish::Game

RSpec.describe Player do
  let(:game) { Game.new(2) }
  subject(:player1) { game.create_player("Test Player") }

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
      subject.secret_hand.cards.clear

      expect(subject.secret_hand_empty?).to be true
    end
    it "returns false if their secret hand isn't empty" do
      expect(subject.secret_hand_empty?).to be false
    end
  end

  describe "#ask_for_card" do
    context "when asking a non-existant player" do
      it "returns nil" do
        expect(subject.ask_for_card("Non-existant", RubyCards::Card.new)).to be_nil
      end
    end

    context "when asking another player" do
      let(:player2) { game.create_player("Test Player 2") }

      it "returns nil if we do not have the card" do
        card = find_card_not_in_hand(subject.secret_hand)
        expect(subject.ask_for_card("Test Player 2", card)).to be_nil
      end

      context "and that player has the card" do
        let(:card) { player2.secret_hand.cards[0] }

        it "returns true" do
          expect(subject.ask_for_card("Test Player 2", card)).to be true
        end
        it "transfers all of the same-ranked cards into Player's hand" do
          cards = player2.secret_hand.select { |c| c.rank == card.rank }

          subject.ask_for_card("Test Player 2", card)

          cards.each do |c|
            expect(player1.secret_hand).to include c
            expect(player2.secret_hand).not_to include c
          end
        end
      end

      context "and that player doesn't have the card" do
        it "returns false if we do not fish the card" do
        end
        it "returns true if we DO fish the card" do
        end
      end
    end
  end

  describe "#transfer_card" do
    context "when involving a non-existant player" do
      it "returns nil if player_one doesn't exist" do
      end
      it "returns nil if player_two doesn't exist" do
      end
    end

    context "when transferring to another player" do
      let(:player2) { game.create_player("Test Player 2") }

      it "returns nil if player_one does not have the card" do
        card = find_card_not_in_hand(player1.secret_hand)
        expect(player1.transfer_card(player1, player2, card)).to be_nil
      end
      it "returns true after transferring card between players" do
      end
      it "removes the card from player_one's hand" do
      end
      it "adds the card to player_two's hand" do
      end
    end
  end
end
