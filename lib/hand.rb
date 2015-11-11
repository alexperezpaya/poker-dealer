class Hand < PokerHand

  def self.best_hand_from_cards(cards)
    cards = cards.split(' ') if cards.is_a? String
    comparing_hands = cards.combination(5).to_a
    comparing_hands.map { |hand| Hand.new(hand)}
    Hand.new(comparing_hands.max)
  end

end
