require_relative 'card'
require_relative 'deck'

class DeckBuilder

  def self.create
    Deck.new(card_list_for(THE_EXCUSE) + card_list_for(ACES) + card_list_for(NUMBER_CARDS) + card_list_for(CROWNS))
  end

  private
  def self.card_list_for(options_list)
    options_list.map{ |options| Card.new(**options) }
  end

  THE_EXCUSE = [ {name: 'the EXCUSE'} ]

  ACES = [
    {name: 'the ACE of MOONS',  rank: :ace, suits: [:moons]},
    {name: 'the ACE of SUNS',   rank: :ace, suits: [:suns]},
    {name: 'the ACE of WAVES',  rank: :ace, suits: [:waves]},
    {name: 'the ACE of LEAVES', rank: :ace, suits: [:leaves]},
    {name: 'the ACE of WYRMS',  rank: :ace, suits: [:wyrms]},
    {name: 'the ACE of KNOTS',  rank: :ace, suits: [:knots]}
  ]

  NUMBER_CARDS = [
    {name: 'the AUTHOR',         rank: 2, suits: [:moons, :knots],  types: [:personality]},
    {name: 'the DESERT',         rank: 2, suits: [:suns, :wyrms],   types: [:location]},
    {name: 'the ORIGIN',         rank: 2, suits: [:waves, :leaves], types: [:location, :event]},
    {name: 'the JOURNEY',        rank: 3, suits: [:moons, :waves],  types: [:event]},
    {name: 'the PAINTER',        rank: 3, suits: [:suns, :knots],   types: [:personality]},
    {name: 'the SAVAGE',         rank: 3, suits: [:leaves, :wyrms], types: [:personality]},
    {name: 'the MOUNTAIN',       rank: 4, suits: [:moons, :suns],   types: [:location]},
    {name: 'the SAILOR',         rank: 4, suits: [:waves, :leaves], types: [:personality]},
    {name: 'the BATTLE',         rank: 4, suits: [:wyrms, :knots],  types: [:event]},
    {name: 'the FOREST',         rank: 5, suits: [:moons, :leaves], types: [:location]},
    {name: 'the DISCOVERY',      rank: 5, suits: [:suns, :waves],   types: [:event]},
    {name: 'the SOLDIER',        rank: 5, suits: [:wyrms, :knots],  types: [:personality]},
    {name: 'the LUNATIC',        rank: 6, suits: [:moons, :waves],  types: [:personality]},
    {name: 'the PENITENT',       rank: 6, suits: [:suns, :wyrms],   types: [:personality]},
    {name: 'the MARKET',         rank: 6, suits: [:leaves, :knots], types: [:location, :event]},
    {name: 'the CHANCE MEETING', rank: 7, suits: [:moons, :leaves], types: [:event]},
    {name: 'the CASTLE',         rank: 7, suits: [:suns, :knots],   types: [:location]},
    {name: 'the CAVE',           rank: 7, suits: [:waves, :wyrms],  types: [:location]},
    {name: 'the DIPLOMAT',       rank: 8, suits: [:moons, :suns],   types: [:personality]},
    {name: 'the MILL',           rank: 8, suits: [:waves, :leaves], types: [:location]},
    {name: 'the BETRAYAL',       rank: 8, suits: [:wyrms, :knots],  types: [:event]},
    {name: 'the PACT',           rank: 9, suits: [:moons, :suns],   types: [:event]},
    {name: 'the DARKNESS',       rank: 9, suits: [:waves, :wyrms],  types: [:location]},
    {name: 'the MERCHANT',       rank: 9, suits: [:leaves, :knots], types: [:personality]}
  ]

  PAWNS = [
    {name: 'the HARVEST',      rank: :pawn, suits: [:moons, :suns, :leaves],  types: [:event]},
    {name: 'the WATCHMAN',     rank: :pawn, suits: [:moons, :wyrms, :knots],  types: [:personality]},
    {name: 'the LIGHT KEEPER', rank: :pawn, suits: [:suns, :waves, :knots],   types: [:personality]},
    {name: 'the BORDERLAND',   rank: :pawn, suits: [:waves, :leaves, :wyrms], types: [:location]}
  ]

  COURTS = [
    {name: 'the CONSUL', rank: :court, suits: [:moons, :waves, :knots],  types: [:personality]},
    {name: 'the RITE',   rank: :court, suits: [:moons, :leaves, :wyrms], types: [:event]},
    {name: 'the ISLAND', rank: :court, suits: [:suns, :waves, :wyrms],   types: [:location]},
    {name: 'the WINDOW', rank: :court, suits: [:suns, :leaves, :knots],  types: [:location]}
  ]

  CROWNS = [
    {name: 'the HUNTRESS', rank: :crown, suits: [:moons],  types: [:personality]},
    {name: 'the BARD',     rank: :crown, suits: [:suns],   types: [:personality]},
    {name: 'the SEA',      rank: :crown, suits: [:waves],  types: [:location]},
    {name: 'the END',      rank: :crown, suits: [:leaves], types: [:location, :event]},
    {name: 'the CALAMITY', rank: :crown, suits: [:wyrms],  types: [:event]},
    {name: 'the WINDFALL', rank: :crown, suits: [:knots],  types: [:event]}
  ]
end
