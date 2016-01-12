class RandomGame
  attr_reader :match

  def initialize
    @match = Match.new
  end

  def run
    5.times do
      match.deal
    end
    match.winner
  end

  def print_status
    p match.round
    case match.round
    when :preflop
      p print_player_cards
    when :flop, :turn, :river
      p print_match
    else
      p match.winner
    end
  end

  def print_match
    p match.table.join(' ')
  end

  def print_player_cards
    match.players_cards.each do |cards|
      p cards.join(' ')
    end
  end

end
