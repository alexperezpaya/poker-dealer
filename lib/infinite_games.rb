class InfiniteGames

  def initialize(&block)
    loop do
      game = RandomGame.new
      game.run
      block.call(game.match)
    end
  end
end
