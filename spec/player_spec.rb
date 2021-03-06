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
    context "when either player is nil" do
      it "returns nil (player_one)" do
        expect(subject.ask_for_card(nil, player1, find_card_in_hand(player1))).to be_nil
      end
      it "returns nil (player_two)" do
        expect(subject.ask_for_card(player1, nil, find_card_in_hand(player1))).to be_nil
      end
    end

    it "returns nil when asking self" do
      expect(subject.ask_for_card(player1, player1, find_card_in_hand(player1))).to be_nil
    end

    context "when asking another player" do
      let(:player2) { game.create_player("Test Player 2") }

      it "returns nil if we do not have the card" do
        card = find_card_not_in_hand(player1)
        expect(subject.ask_for_card(player1, player2, card)).to be_nil
      end

      context "and that player has the card" do
        let(:card) { find_card_in_hand(player2) }

        it "returns true" do
          expect(subject.ask_for_card(player1, player2, card)).to be true
        end
        it "transfers all of the same-ranked cards into Player's hand" do
          cards = player2.secret_hand.select { |c| c.rank == card.rank }

          subject.ask_for_card(player1, player2, card)

          cards.each do |c|
            expect(player1.secret_hand).to include c
            expect(player2.secret_hand).not_to include c
          end
        end
      end

      context "and that player doesn't have the card" do
        let(:card) { find_card_not_in_hand(player2) }
        before :each do
          player1.secret_hand << card
        end

        it "returns false if we do not fish the card" do
          game.deck.cards.reject! { |c| c.rank == card.rank }
          expect(subject.ask_for_card(player1, player2, card)).to be false
        end
        it "returns true if we DO fish the card" do
          game.deck.cards.unshift(card)
          expect(subject.ask_for_card(player1, player2, card)).to be true
        end
      end
    end
  end

  describe "#transfer_card" do
    let(:card) { find_card_in_hand(player1) }

    context "when involving a non-existant player" do
      it "returns nil if player_one doesn't exist" do
        expect(subject.transfer_card(nil, player1, card)).to be_nil
      end
      it "returns nil if player_two doesn't exist" do
        expect(subject.transfer_card(player1, nil, card)).to be_nil
      end
    end

    it "returns nil if both players are the same" do
      expect(subject.transfer_card(player1, player1, card)).to be_nil
    end

    context "when transferring to another player" do
      let(:player2) { game.create_player("Test Player 2") }

      it "returns nil if player_one does not have the card" do
        card = find_card_not_in_hand(player1)
        expect(subject.transfer_card(player1, player2, card)).to be_nil
      end
      it "returns true" do
        expect(subject.transfer_card(player1, player2, card)).to be true
      end
      it "removes the card from player_one's hand" do
        expect(player1.secret_hand).to include card

        subject.transfer_card(player1, player2, card)

        expect(player1.secret_hand).not_to include card
      end
      it "adds the card to player_two's hand" do
        expect(player2.secret_hand).not_to include card

        subject.transfer_card(player1, player2, card)

        expect(player2.secret_hand).to include card
      end
    end
  end
end
