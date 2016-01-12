require 'bundler'
require 'rspec/autorun'

Bundler.require :default, :test
require_all 'lib'
PokerHand.allow_duplicates = false

describe Match do
  before do
    @match = Match.new
  end

  describe 'setup round' do
    before do
      @match.deal
    end

    it 'deals 2 cards to each player and passes to preflop' do
      expect(@match.players_cards.flatten.count).to be(@match.players * 2)
    end

    it 'passes to preflop' do
      expect(@match.round).to be(:preflop)
    end
  end

  describe 'preflop round' do
    before do
      2.times { @match.deal }
    end

    it 'deals 3 cards to the table and passes to flop' do
      expect(@match.table.count).to be(3)
    end

    it 'passes to flop' do
      expect(@match.round).to be(:flop)
    end
  end

  describe 'flop round' do
    before do
      3.times { @match.deal }
    end

    it 'deals 1 more card card to the table and passes to turn' do
      expect(@match.table.count).to be(4)
    end

    it 'passes to turn' do
      expect(@match.round).to be(:turn)
    end
  end

  describe 'turn round' do
    before do
      4.times { @match.deal }
    end

    it 'deals the last card card to the table' do
      expect(@match.table.count).to be(5)
    end

    it 'passes to river' do
      expect(@match.round).to be(:river)
    end
  end

  describe 'river round' do
    before do
      5.times { @match.deal }
    end

    it 'maintains the table with 5 cards' do
      expect(@match.table.count).to be(5)
    end

    it 'ends the match' do
      expect(@match.round).to be(:ended)
    end

    it 'has a winner game result' do
      expect(@match.winner.class).to be(GameResult)
    end
  end
end
