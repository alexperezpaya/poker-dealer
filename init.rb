require 'bundler'
Bundler.require :default
require_all 'lib'
PokerHand.allow_duplicates = false

InfiniteGames.new do |game|
  p game.winner.textify
  rest_of_hands = game.players_hands.dup
  rest_of_hands.delete(game.winner.hand)
  rest_of_hands.each do |hand|
    p hand.rank
  end
end
