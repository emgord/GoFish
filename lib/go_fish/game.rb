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
      player.secret_hand.draw(@deck,5)
      @players.push(player)
    end

    def pick_starting_player(num_players)
    end

    def game_over?
    end

    def turn(player)
    end

    def secret_hand_empty?
    end

    def print_status
    end

  end
end
