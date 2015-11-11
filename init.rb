require 'bundler'
Bundler.require :default
require_all 'lib'
PokerHand.allow_duplicates = false

InfiniteGames.new do |deck|
  p deck.winner.textify
  rest_of_hands = deck.players_hands.dup
  rest_of_hands.delete(deck.winner.hand)
  rest_of_hands.each do |hand|
    p hand.rank
  end
end
