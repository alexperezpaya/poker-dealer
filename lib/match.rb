class Match
  attr_reader :players,
              :round,
              :deck,
              :table,
              :players_cards

  def initialize(deck: shuffled_deck, table: [],
                 players: 4, players_cards: [], round: rounds.first)
    @deck = deck
    @table = table
    @players = players
    @players_cards = players_cards
    @round = round
  end

  def deal
    dealer_for(round: @round)&.deal(self)
    @round = rounds[rounds.index(round)+1] || rounds.last
  end

  def deal_card
    deck.pop
  end

  def deal_card_to_table
    @table << deal_card
  end

  def players_hands
    players_cards.map do |cards|
      Hand.best_hand_from_cards([table, cards].flatten)
    end
  end

  def winner
    GameResult.new(hand: best_hand,
                   hand_name: best_hand.rank,
                   hand_cards: best_hand.just_cards,
                   winner: players_hands.index(best_hand)) if round == :ended
  end

  private

  def rounds
    [:setup, :preflop, :flop, :turn, :river, :ended]
  end

  def best_hand
    players_hands.max
  end

  def dealer_for(round: )
    case round
    when :setup
      SetupDealer
    when :preflop
      PreflopDealer
    when :flop, :turn
      RoundDealer
    end
  end

  def shuffled_deck
    generate.shuffle
  end

  def generate
    figures.map do |number|
      types.map do |type|
        "#{number}#{type}"
      end
    end.flatten
  end

  def types
    ['C', 'D', 'H', 'S']
  end

  def figures
    ['A', 2, 3, 4, 5, 6, 7, 8, 9, 'T', 'J', 'Q', 'K']
  end
end

module RoundDealer
  extend self

  def deal(match)
    match.deal_card_to_table
  end
end

module PreflopDealer
  extend self

  def deal(match)
    3.times do
      match.deal_card_to_table
    end
  end
end

module SetupDealer
  extend self

  def deal(match)
    match.players.times do
      match.players_cards << [match.deal_card, match.deal_card]
    end
  end
end
