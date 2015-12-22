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
      puts "#{self.name} secret cards are:"
      puts self.secret_hand
      puts "#{self.name} table cards are:"
      puts self.table_hand
    end

    def print_table_hand(players)
      players.each do |player|
        puts "#{player.name} has #{player.table_hand.count} cards on the table and #{player.secret_hand.count} secret cards"
      end
    end


    def ask_for_card(player_one, player_two, chosen_card)
      if !secret_hand_empty?
        if have_cards?(player_one, chosen_card)
          if have_cards?(player_two, chosen_card)
            transfer_card(player_one, player_two, chosen_card)
          else
          puts "GO FISH!!!!!!!!!!!"
          go_fish(game.deck)
          end
        else puts "You don't have that card"
        end
      else draw_five_cards(deck)
      end
    end

    def have_cards?(player, card)
      return true if player.secret_hand.cards.include?(card)
    end


    def transfer_card(player_one, player_two, chosen_card)
        player_two.cards.secret_hand.each do |card|
          if chosen_card == card
            player_one.secret_hand.push(card)
            player_two.cards.delete(card)
          end
        end
    end

    def go_fish(deck)
      @secret_hand.draw(deck,1)
    end

    def play_fours
      hand_to_hash.each do |card_rank, number|
        if number == 4
          move_to_table_hand(card_rank)
        end
      end
    end

    def move_to_table_hand(card_rank)
      @secret_hand.each do |card|
        if card.rank.to_i == card_rank
          @secret_hand.cards.delete(card)
          @table_hand.cards.push(card)
        end
      end
    end

    def hand_to_hash
      hand_hash = {}
      @secret_hand.each do |card|
        if hand_hash[card.rank.to_i]
          hand_hash[card.rank.to_i] += 1
        else
          hand_hash[card.rank.to_i] = 1
        end
      end
      return hand_hash
    end

    def draw_five_cards(deck)
      @secret_hand.draw(deck,5)
    end

  end

end
