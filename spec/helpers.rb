module Helpers
  def find_card_not_in_hand(hand)
    card = RubyCards::Card.new(2, 'Club')
    while hand.cards.include? card
      card = RubyCards::Card.new(card.rank.to_i + 1, 'Club')
    end

    return card
  end
end
