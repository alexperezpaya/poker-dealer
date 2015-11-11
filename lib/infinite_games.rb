class InfiniteGames

  def initialize(&block)
    loop do
      game = RandomGame.new
      game.run
      block.call(game.deck)
    end
  end

end
