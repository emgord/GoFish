module GoFish
  class Player
    attr_accessor :name, :secret_hand, :table_hand

    def initialize(name)
      @name = name
      @secret_hand = Hand.new.drow(@deck, 5)
      @table_hand = Hand.new
    end


  end

end
