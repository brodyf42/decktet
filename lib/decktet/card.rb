module Decktet
  class Card
    attr_reader :name, :rank, :suits, :types
    private_class_method :new

    RANKS = ([:ace] + Array(2..9) + [:pawn, :court, :crown]).freeze
    SUITS = [:moons, :suns, :waves, :leaves, :wyrms, :knots].freeze
    TYPES = [:location, :personality, :event].freeze

    def excuse? = rank.nil? && suits.nil? && types.nil?

    (RANKS - Array(2..9) ).each { |rank| define_method(:"#{rank}?") { self.rank == rank  } }
    SUITS.each { |suit| define_method(:"#{suit}?") { suits&.include?(suit) || false } }
    TYPES.each { |type| define_method(:"#{type}?") { types&.include?(type) || false } }

    private

    def initialize(name:, rank: nil, suits: nil, types: nil)
      @name = name
      @rank = rank
      @suits = suits
      @types = types
    end

    THE_EXCUSE         = new(name: 'the EXCUSE').freeze

    THE_ACE_OVE_MOONS  = new(name: 'the ACE of MOONS',  rank: :ace, suits: [:moons]).freeze
    THE_ACE_OF_SUNS    = new(name: 'the ACE of SUNS',   rank: :ace, suits: [:suns]).freeze
    THE_ACE_OF_WAVES   = new(name: 'the ACE of WAVES',  rank: :ace, suits: [:waves]).freeze
    THE_ACE_OF_LEAVES  = new(name: 'the ACE of LEAVES', rank: :ace, suits: [:leaves]).freeze
    THE_ACE_OF_WYRMS   = new(name: 'the ACE of WYRMS',  rank: :ace, suits: [:wyrms]).freeze
    THE_ACE_OF_KNOTS   = new(name: 'the ACE of KNOTS',  rank: :ace, suits: [:knots]).freeze

    THE_AUTHOR         = new(name: 'the AUTHOR',         rank: 2, suits: [:moons, :knots],  types: [:personality])
    THE_DESERT         = new(name: 'the DESERT',         rank: 2, suits: [:suns, :wyrms],   types: [:location]).freeze
    THE_ORIGIN         = new(name: 'the ORIGIN',         rank: 2, suits: [:waves, :leaves], types: [:location, :event]).freeze
    THE_JOURNEY        = new(name: 'the JOURNEY',        rank: 3, suits: [:moons, :waves],  types: [:event]).freeze
    THE_PAINTER        = new(name: 'the PAINTER',        rank: 3, suits: [:suns, :knots],   types: [:personality]).freeze
    THE_SAVAGE         = new(name: 'the SAVAGE',         rank: 3, suits: [:leaves, :wyrms], types: [:personality]).freeze
    THE_MOUNTAIN       = new(name: 'the MOUNTAIN',       rank: 4, suits: [:moons, :suns],   types: [:location]).freeze
    THE_SAILOR         = new(name: 'the SAILOR',         rank: 4, suits: [:waves, :leaves], types: [:personality]).freeze
    THE_BATTLE         = new(name: 'the BATTLE',         rank: 4, suits: [:wyrms, :knots],  types: [:event]).freeze
    THE_FOREST         = new(name: 'the FOREST',         rank: 5, suits: [:moons, :leaves], types: [:location]).freeze
    THE_DISCOVERY      = new(name: 'the DISCOVERY',      rank: 5, suits: [:suns, :waves],   types: [:event]).freeze
    THE_SOLDIER        = new(name: 'the SOLDIER',        rank: 5, suits: [:wyrms, :knots],  types: [:personality]).freeze
    THE_LUNATIC        = new(name: 'the LUNATIC',        rank: 6, suits: [:moons, :waves],  types: [:personality]).freeze
    THE_PENITENT       = new(name: 'the PENITENT',       rank: 6, suits: [:suns, :wyrms],   types: [:personality]).freeze
    THE_MARKET         = new(name: 'the MARKET',         rank: 6, suits: [:leaves, :knots], types: [:location, :event]).freeze
    THE_CHANCE_MEETING = new(name: 'the CHANCE MEETING', rank: 7, suits: [:moons, :leaves], types: [:event]).freeze
    THE_CASTLE         = new(name: 'the CASTLE',         rank: 7, suits: [:suns, :knots],   types: [:location]).freeze
    THE_CAVE           = new(name: 'the CAVE',           rank: 7, suits: [:waves, :wyrms],  types: [:location]).freeze
    THE_DIPLOMAT       = new(name: 'the DIPLOMAT',       rank: 8, suits: [:moons, :suns],   types: [:personality]).freeze
    THE_MILL           = new(name: 'the MILL',           rank: 8, suits: [:waves, :leaves], types: [:location]).freeze
    THE_BETRAYAL       = new(name: 'the BETRAYAL',       rank: 8, suits: [:wyrms, :knots],  types: [:event]).freeze
    THE_PACT           = new(name: 'the PACT',           rank: 9, suits: [:moons, :suns],   types: [:event]).freeze
    THE_DARKNESS       = new(name: 'the DARKNESS',       rank: 9, suits: [:waves, :wyrms],  types: [:location]).freeze
    THE_MERCHANT       = new(name: 'the MERCHANT',       rank: 9, suits: [:leaves, :knots], types: [:personality]).freeze

    THE_HARVEST        = new(name: 'the HARVEST',      rank: :pawn, suits: [:moons, :suns, :leaves],  types: [:event]).freeze
    THE_WATCHMAN       = new(name: 'the WATCHMAN',     rank: :pawn, suits: [:moons, :wyrms, :knots],  types: [:personality]).freeze
    THE_LIGHT_KEEPER   = new(name: 'the LIGHT KEEPER', rank: :pawn, suits: [:suns, :waves, :knots],   types: [:personality]).freeze
    THE_BORDERLAND     = new(name: 'the BORDERLAND',   rank: :pawn, suits: [:waves, :leaves, :wyrms], types: [:location]).freeze

    THE_CONSUL         = new(name: 'the CONSUL', rank: :court, suits: [:moons, :waves, :knots],  types: [:personality]).freeze
    THE_RITE           = new(name: 'the RITE',   rank: :court, suits: [:moons, :leaves, :wyrms], types: [:event]).freeze
    THE_ISLAND         = new(name: 'the ISLAND', rank: :court, suits: [:suns, :waves, :wyrms],   types: [:location]).freeze
    THE_WINDOW         = new(name: 'the WINDOW', rank: :court, suits: [:suns, :leaves, :knots],  types: [:location]).freeze

    THE_HUNTRESS       = new(name: 'the HUNTRESS', rank: :crown, suits: [:moons],  types: [:personality]).freeze
    THE_BARD           = new(name: 'the BARD',     rank: :crown, suits: [:suns],   types: [:personality]).freeze
    THE_SEA            = new(name: 'the SEA',      rank: :crown, suits: [:waves],  types: [:location]).freeze
    THE_END            = new(name: 'the END',      rank: :crown, suits: [:leaves], types: [:location, :event]).freeze
    THE_CALAMITY       = new(name: 'the CALAMITY', rank: :crown, suits: [:wyrms],  types: [:event]).freeze
    THE_WINDFALL       = new(name: 'the WINDFALL', rank: :crown, suits: [:knots],  types: [:event]).freeze

    ACES = [THE_ACE_OVE_MOONS, THE_ACE_OF_SUNS, THE_ACE_OF_WAVES, THE_ACE_OF_LEAVES, THE_ACE_OF_WYRMS, THE_ACE_OF_KNOTS].freeze

    NUMBER_CARDS = [
      THE_AUTHOR, THE_DESERT, THE_ORIGIN,       # rank 2
      THE_JOURNEY, THE_PAINTER, THE_SAVAGE,     # rank 3
      THE_MOUNTAIN, THE_SAILOR, THE_BATTLE,     # rank 4
      THE_FOREST, THE_DISCOVERY, THE_SOLDIER,   # rank 5
      THE_LUNATIC, THE_PENITENT, THE_MARKET,    # rank 6
      THE_CHANCE_MEETING, THE_CASTLE, THE_CAVE, # rank 7
      THE_DIPLOMAT, THE_MILL, THE_BETRAYAL,     # rank 8
      THE_PACT, THE_DARKNESS, THE_MERCHANT      # rank 9
    ].freeze

    PAWNS = [THE_HARVEST, THE_WATCHMAN, THE_LIGHT_KEEPER, THE_BORDERLAND].freeze
    COURTS = [THE_CONSUL, THE_RITE, THE_ISLAND, THE_WINDOW].freeze
    CROWNS = [THE_HUNTRESS, THE_BARD, THE_SEA, THE_END, THE_CALAMITY, THE_WINDFALL].freeze
  end
end
