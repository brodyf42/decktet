module Decktet
  RANKS = ([:ace] + Array(2..9) + %i[pawn court crown]).freeze
  SUITS = %i[moons suns waves leaves wyrms knots].freeze
  TYPES = %i[location personality event].freeze

  Card = Data.define(:name, :rank, :suits, :types) do
    def initialize(name:, rank: nil, suits: nil, types: nil)
      super(name: name.freeze, rank:, suits: Array(suits).freeze, types: Array(types).freeze)
    end

    def excuse? = rank.nil? && suits.empty? && types.empty?
    def number? = Integer === rank

    RANKS.select { |r| Symbol === r }.each { |rank| define_method(:"#{rank}?") { self.rank == rank } }
    SUITS.each { |suit| define_method(:"#{suit}?") { suits.include?(suit) } }
    TYPES.each { |type| define_method(:"#{type}?") { types.include?(type) } }

    alias_method :moon?, :moons?
    alias_method :sun?,  :suns?
    alias_method :wave?, :waves?
    alias_method :leaf?, :leaves?
    alias_method :wyrm?, :wyrms?
    alias_method :knot?, :knots?
  end

  THE_EXCUSE         = Card.new('the EXCUSE')

  THE_ACE_OF_MOONS   = Card.new('the ACE of MOONS',  :ace,    :moons)
  THE_ACE_OF_SUNS    = Card.new('the ACE of SUNS',   :ace,    :suns)
  THE_ACE_OF_WAVES   = Card.new('the ACE of WAVES',  :ace,    :waves)
  THE_ACE_OF_LEAVES  = Card.new('the ACE of LEAVES', :ace,    :leaves)
  THE_ACE_OF_WYRMS   = Card.new('the ACE of WYRMS',  :ace,    :wyrms)
  THE_ACE_OF_KNOTS   = Card.new('the ACE of KNOTS',  :ace,    :knots)

  THE_AUTHOR         = Card.new('the AUTHOR',         2,      %i[moons knots],        :personality)
  THE_DESERT         = Card.new('the DESERT',         2,      %i[suns wyrms],         :location)
  THE_ORIGIN         = Card.new('the ORIGIN',         2,      %i[waves leaves],       %i[location event])
  THE_JOURNEY        = Card.new('the JOURNEY',        3,      %i[moons waves],        :event)
  THE_PAINTER        = Card.new('the PAINTER',        3,      %i[suns knots],         :personality)
  THE_SAVAGE         = Card.new('the SAVAGE',         3,      %i[leaves wyrms],       :personality)
  THE_MOUNTAIN       = Card.new('the MOUNTAIN',       4,      %i[moons suns],         :location)
  THE_SAILOR         = Card.new('the SAILOR',         4,      %i[waves leaves],       :personality)
  THE_BATTLE         = Card.new('the BATTLE',         4,      %i[wyrms knots],        :event)
  THE_FOREST         = Card.new('the FOREST',         5,      %i[moons leaves],       :location)
  THE_DISCOVERY      = Card.new('the DISCOVERY',      5,      %i[suns waves],         :event)
  THE_SOLDIER        = Card.new('the SOLDIER',        5,      %i[wyrms knots],        :personality)
  THE_LUNATIC        = Card.new('the LUNATIC',        6,      %i[moons waves],        :personality)
  THE_PENITENT       = Card.new('the PENITENT',       6,      %i[suns wyrms],         :personality)
  THE_MARKET         = Card.new('the MARKET',         6,      %i[leaves knots],       %i[location event])
  THE_CHANCE_MEETING = Card.new('the CHANCE MEETING', 7,      %i[moons leaves],       :event)
  THE_CASTLE         = Card.new('the CASTLE',         7,      %i[suns knots],         :location)
  THE_CAVE           = Card.new('the CAVE',           7,      %i[waves wyrms],        :location)
  THE_DIPLOMAT       = Card.new('the DIPLOMAT',       8,      %i[moons suns],         :personality)
  THE_MILL           = Card.new('the MILL',           8,      %i[waves leaves],       :location)
  THE_BETRAYAL       = Card.new('the BETRAYAL',       8,      %i[wyrms knots],        :event)
  THE_PACT           = Card.new('the PACT',           9,      %i[moons suns],         :event)
  THE_DARKNESS       = Card.new('the DARKNESS',       9,      %i[waves wyrms],        :location)
  THE_MERCHANT       = Card.new('the MERCHANT',       9,      %i[leaves knots],       :personality)

  THE_HARVEST        = Card.new('the HARVEST',        :pawn,  %i[moons suns leaves],  :event)
  THE_WATCHMAN       = Card.new('the WATCHMAN',       :pawn,  %i[moons wyrms knots],  :personality)
  THE_LIGHT_KEEPER   = Card.new('the LIGHT KEEPER',   :pawn,  %i[suns waves knots],   :personality)
  THE_BORDERLAND     = Card.new('the BORDERLAND',     :pawn,  %i[waves leaves wyrms], :location)

  THE_CONSUL         = Card.new('the CONSUL',         :court, %i[moons waves knots],  :personality)
  THE_RITE           = Card.new('the RITE',           :court, %i[moons leaves wyrms], :event)
  THE_ISLAND         = Card.new('the ISLAND',         :court, %i[suns waves wyrms],   :location)
  THE_WINDOW         = Card.new('the WINDOW',         :court, %i[suns leaves knots],  :location)

  THE_HUNTRESS       = Card.new('the HUNTRESS',       :crown, :moons,                 :personality)
  THE_BARD           = Card.new('the BARD',           :crown, :suns,                  :personality)
  THE_SEA            = Card.new('the SEA',            :crown, :waves,                 :location)
  THE_END            = Card.new('the END',            :crown, :leaves,                %i[location event])
  THE_CALAMITY       = Card.new('the CALAMITY',       :crown, :wyrms,                 :event)
  THE_WINDFALL       = Card.new('the WINDFALL',       :crown, :knots,                 :event)

  Card.class_eval { private_class_method :new }

  CARDS = [
    THE_EXCUSE,
    THE_ACE_OF_MOONS, THE_ACE_OF_SUNS, THE_ACE_OF_WAVES, THE_ACE_OF_LEAVES, THE_ACE_OF_WYRMS, THE_ACE_OF_KNOTS,
    THE_AUTHOR, THE_DESERT, THE_ORIGIN,                                   # rank 2
    THE_JOURNEY, THE_PAINTER, THE_SAVAGE,                                 # rank 3
    THE_MOUNTAIN, THE_SAILOR, THE_BATTLE,                                 # rank 4
    THE_FOREST, THE_DISCOVERY, THE_SOLDIER,                               # rank 5
    THE_LUNATIC, THE_PENITENT, THE_MARKET,                                # rank 6
    THE_CHANCE_MEETING, THE_CASTLE, THE_CAVE,                             # rank 7
    THE_DIPLOMAT, THE_MILL, THE_BETRAYAL,                                 # rank 8
    THE_PACT, THE_DARKNESS, THE_MERCHANT,                                 # rank 9
    THE_HARVEST, THE_WATCHMAN, THE_LIGHT_KEEPER, THE_BORDERLAND,          # pawns
    THE_CONSUL, THE_RITE, THE_ISLAND, THE_WINDOW,                         # courts
    THE_HUNTRESS, THE_BARD, THE_SEA, THE_END, THE_CALAMITY, THE_WINDFALL, # crowns
  ].freeze

  ACES          = CARDS.select(&:ace?).freeze
  NUMBERS       = CARDS.select(&:number?).freeze
  PAWNS         = CARDS.select(&:pawn?).freeze
  COURTS        = CARDS.select(&:court?).freeze
  CROWNS        = CARDS.select(&:crown?).freeze

  MOONS         = CARDS.select(&:moons?).freeze
  SUNS          = CARDS.select(&:suns?).freeze
  WAVES         = CARDS.select(&:waves?).freeze
  LEAVES        = CARDS.select(&:leaves?).freeze
  WYRMS         = CARDS.select(&:wyrms?).freeze
  KNOTS         = CARDS.select(&:knots?).freeze

  LOCATIONS     = CARDS.select(&:location?).freeze
  PERSONALITIES = CARDS.select(&:personality?).freeze
  EVENTS        = CARDS.select(&:event?).freeze
end
