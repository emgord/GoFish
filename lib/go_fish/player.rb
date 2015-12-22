module GoFish
  class Player
    attr_accessor :name, :secret_hand, :table_hand

    def initialize(name)
      @name = name
      @secret_hand = Hand.new
      @table_hand = Hand.new
    end

    def secret_hand_empty?
      if @secret_hand.count == 0
        true
      else
        false
      end
    end

    def print_status
    end

    def ask_for_card(player_name, card)
      # do you even have card?
      # does that player have card?
      # either take the card and repeat this method or
      # go fish
    end

    def transfer_card(player_one, player_two, card)
    end

    def go_fish(deck)
      @secret_hand.draw(deck,1)
    end

    def play_fours
      @secret_hand.each do |card|
    end

    def hand_to_hash(hand)
      hand_hash = {}
      hand.each do |card|
        if hand_hash[card]
          hand_hash[card] += 1
        else
          hand_hash[card] = 1
        end
      end
      return hand_hash
    end

    def draw_five_cards(deck)
      @secret_hand.draw(deck,5)
    end

  end

end
