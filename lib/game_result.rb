class GameResult
  attr_accessor :winner,
                :hand,
                :hand_name,
                :hand_cards

  def textify
    "Player #{winner} wins with #{hand_name} (#{hand_cards})"
  end
end
