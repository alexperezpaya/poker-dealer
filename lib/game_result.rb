class GameResult
  attr_reader :winner,
              :hand,
              :hand_name,
              :hand_cards

  def initialize(params)
    @winner = params[:winner]
    @hand = params[:hand]
    @hand_name = params[:hand_name]
    @hand_cards = params[:hand_cards]
  end

  def textify
    "Player #{winner} wins with #{hand_name} (#{hand_cards})"
  end
end
