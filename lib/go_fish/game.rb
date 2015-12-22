module GoFish
  class Game
    attr_accessor :num_players, :deck, :players

    def initialize(num_players)
      @num_players = num_players
      @players = []
      @deck = Deck.new.shuffle!
      @starting_player = pick_starting_player(num_players)
    end

    def create_player(name)
      player = GoFish::Player.new(name)
      player.draw_five_cards(@deck)
      @players.push(player)
    end

    def pick_starting_player(num_players)
      starter_index = rand(num_players)
      return @players[starter_index]
    end

    def game_over?
      @players.each do |player|
        if !player.secret_hand_empty?
          return false
        end
      end
      return true
    end

    def turn(player)

    end

  end
end
