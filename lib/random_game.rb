class RandomGame
  attr_accessor :deck

  def initialize
    self.deck = Deck.new
  end

  def run
    5.times do
      deck.deliver
    end
    deck.winner
  end

  def print_status
    p deck.round
    case deck.round
    when :preflop
      p print_player_cards
    when :flop, :turn, :river
      p print_deck
    else
      p deck.winner
    end
  end

  def print_deck
    p deck.table.join(' ')
  end

  def print_player_cards
    deck.players_cards.each do |cards|
      p cards.join(' ')
    end
  end

end
