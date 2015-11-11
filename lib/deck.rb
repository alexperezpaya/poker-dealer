class Deck
  attr_accessor :players,
                :round,
                :deck,
                :table,
                :players_cards

  def initialize
    self.deck = shuffled_deck
    self.table = []
    self.players = 4
    self.players_cards = []
    self.round = rounds.first
  end

  def types
    ['C', 'D', 'H', 'S']
  end

  def figures
    ['A', 2, 3, 4, 5, 6, 7, 8, 9, 'T', 'J', 'Q', 'K']
  end

  def generate
    figures.map do |number|
      types.map do |type|
        "#{number}#{type}"
      end
    end.flatten
  end

  def shuffled_deck
    generate.shuffle
  end

  def deal_card
    deck.pop
  end

  def deliver
    case round
    when :none
      players.times do
        self.players_cards << [deal_card, deal_card]
      end
      self.round = :preflop
    when :preflop
      3.times do
        self.table << deal_card
      end
      self.round = :flop
    when :flop
      self.table << deal_card
      self.round = :turn
    when :turn
      self.table << deal_card
      self.round = :river
    when :river
      self.table << deal_card
      self.round = :ended
    end
  end

  def winner
    return nil unless round == :ended
    best_hands = players_hands
    best_hand = best_hands.max
    result = GameResult.new
    result.hand = best_hand
    result.hand_name = best_hand.rank
    result.hand_cards = best_hand.just_cards
    result.winner = best_hands.index(best_hand)
    result
  end

  def players_hands
    players_cards.map do |cards|
      Hand.best_hand_from_cards([table, cards].flatten)
    end
  end

  def rounds
    [:none, :preflop, :flop, :turn, :river, :ended]
  end

end
