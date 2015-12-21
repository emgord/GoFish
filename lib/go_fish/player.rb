module GoFish
  class Player
    attr_accessor :name, :secret_hand, :table_hand

    def initialize(name)
      @name = name
      @secret_hand = Hand.new
      @table_hand = Hand.new
    end

    def secret_hand_empty?
    end

    def print_status
    end

    def ask_for_card(player_name, card)
      # do you even have card?
      # does that player have card?
      # either take the card and repeat this method or
      # go fish
    end

    def go_fish
    end

    def play_fours
    end

    def draw_five_cards
    end

  end

end
