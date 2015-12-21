module GoFish
  class Game
    attr_accessor :num_players, :deck, :players

    def initialize(num_players)
      @num_players = num_players
      @players = []
      @deck = Deck.new.shuffle!
    end

    def create_player(name)
      player = GoFish::Player.new(name)
      player.draw_five_cards(@deck)
      @players.push(player)
    end

    def pick_starting_player(num_players)
    end

    def game_over?
    end

    def turn(player)
    end

  end
end
