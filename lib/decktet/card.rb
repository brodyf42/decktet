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

  THE_EXCUSE          = Card.new('The EXCUSE')

  THE_ACE_OF_MOONS    = Card.new('The Ace of Moons',   :ace,    :moons)
  THE_ACE_OF_SUNS     = Card.new('The Ace of Suns',    :ace,    :suns)
  THE_ACE_OF_WAVES    = Card.new('The Ace of Waves',   :ace,    :waves)
  THE_ACE_OF_LEAVES   = Card.new('The Ace of Leaves',  :ace,    :leaves)
  THE_ACE_OF_WYRMS    = Card.new('The Ace of Wyrms',   :ace,    :wyrms)
  THE_ACE_OF_KNOTS    = Card.new('The Ace of Knots',   :ace,    :knots)

  # Classic Decktet Cards
  THE_AUTHOR          = Card.new('The Author',          2,      %i[moons knots],        :personality)
  THE_DESERT          = Card.new('The Desert',          2,      %i[suns wyrms],         :location)
  THE_ORIGIN          = Card.new('The Origin',          2,      %i[waves leaves],       %i[location event])
  THE_JOURNEY         = Card.new('The Journey',         3,      %i[moons waves],        :event)
  THE_PAINTER         = Card.new('The Painter',         3,      %i[suns knots],         :personality)
  THE_SAVAGE          = Card.new('The Savage',          3,      %i[leaves wyrms],       :personality)
  THE_MOUNTAIN        = Card.new('The Mountain',        4,      %i[moons suns],         :location)
  THE_SAILOR          = Card.new('The Sailor',          4,      %i[waves leaves],       :personality)
  THE_BATTLE          = Card.new('The Battle',          4,      %i[wyrms knots],        :event)
  THE_FOREST          = Card.new('The Forest',          5,      %i[moons leaves],       :location)
  THE_DISCOVERY       = Card.new('The Discovery',       5,      %i[suns waves],         :event)
  THE_SOLDIER         = Card.new('The Soldier',         5,      %i[wyrms knots],        :personality)
  THE_LUNATIC         = Card.new('The Lunatic',         6,      %i[moons waves],        :personality)
  THE_PENITENT        = Card.new('The Penitent',        6,      %i[suns wyrms],         :personality)
  THE_MARKET          = Card.new('The Market',          6,      %i[leaves knots],       %i[location event])
  THE_CHANCE_MEETING  = Card.new('The Chance Meeting',  7,      %i[moons leaves],       :event)
  THE_CASTLE          = Card.new('The Castle',          7,      %i[suns knots],         :location)
  THE_CAVE            = Card.new('The Cave',            7,      %i[waves wyrms],        :location)
  THE_DIPLOMAT        = Card.new('The Diplomat',        8,      %i[moons suns],         :personality)
  THE_MILL            = Card.new('The Mill',            8,      %i[waves leaves],       :location)
  THE_BETRAYAL        = Card.new('The Betrayal',        8,      %i[wyrms knots],        :event)
  THE_PACT            = Card.new('The Pact',            9,      %i[moons suns],         :event)
  THE_DARKNESS        = Card.new('The Darkness',        9,      %i[waves wyrms],        :location)
  THE_MERCHANT        = Card.new('The Merchant',        9,      %i[leaves knots],       :personality)

  THE_HARVEST         = Card.new('The Harvest',         :pawn,  %i[moons suns leaves],  :event)
  THE_WATCHMAN        = Card.new('The Watchman',        :pawn,  %i[moons wyrms knots],  :personality)
  THE_LIGHT_KEEPER    = Card.new('The Light Keeper',    :pawn,  %i[suns waves knots],   :personality)
  THE_BORDERLAND      = Card.new('The Borderland',      :pawn,  %i[waves leaves wyrms], :location)

  THE_CONSUL          = Card.new('The Consul',          :court, %i[moons waves knots],  :personality)
  THE_RITE            = Card.new('The Rite',            :court, %i[moons leaves wyrms], :event)
  THE_ISLAND          = Card.new('The Island',          :court, %i[suns waves wyrms],   :location)
  THE_WINDOW          = Card.new('The Window',          :court, %i[suns leaves knots],  :location)

  THE_HUNTRESS        = Card.new('The Huntress',        :crown, :moons,                 :personality)
  THE_BARD            = Card.new('The Bard',            :crown, :suns,                  :personality)
  THE_SEA             = Card.new('The Sea',             :crown, :waves,                 :location)
  THE_END             = Card.new('The End',             :crown, :leaves,                %i[location event])
  THE_CALAMITY        = Card.new('The Calamity',        :crown, :wyrms,                 :event)
  THE_WINDFALL        = Card.new('The Windfall',        :crown, :knots,                 :event)

  # Capital Decktet cards
  THE_SCULPTOR        = Card.new('The Sculptor',        2,      %i[moons knots],        :personality)
  THE_PILLORY         = Card.new('The Pillory',         2,      %i[suns wyrms],         :location)
  THE_MEMORY          = Card.new('The Memory',          2,      %i[waves leaves],       %i[location event])
  THE_BLIZZARD        = Card.new('The Blizzard',        3,      %i[moons waves],        :event)
  THE_AUDITOR         = Card.new('The Auditor',         3,      %i[suns knots],         :personality)
  THE_MOUNTEBANK      = Card.new('The Mountebank',      3,      %i[leaves wyrms],       :personality)
  THE_GATE            = Card.new('The Gate',            4,      %i[moons suns],         :location)
  THE_MILLER          = Card.new('The Miller',          4,      %i[waves leaves],       :personality)
  THE_ARREST          = Card.new('The Arrest',          4,      %i[wyrms knots],        :event)
  THE_GROVE           = Card.new('The Grove',           5,      %i[moons leaves],       :location)
  THE_APPOINTMENT     = Card.new('The Appointment',     5,      %i[suns waves],         :event)
  THE_ROGUE           = Card.new('The Rogue',           5,      %i[wyrms knots],        :personality)
  THE_NAVIGATOR       = Card.new('The Navigator',       6,      %i[moons waves],        :personality)
  THE_HERMIT          = Card.new('The Hermit',          6,      %i[suns wyrms],         :personality)
  THE_EXHIBITION      = Card.new('The Exhibition',      6,      %i[leaves knots],       %i[location event])
  THE_FORTUITOUS_LOSS = Card.new('The Fortuitous Loss', 7,      %i[moons leaves],       :event)
  THE_FORGE           = Card.new('The Forge',           7,      %i[suns knots],         :location)
  THE_EYE             = Card.new('The Eye',             7,      %i[waves wyrms],        :location)
  THE_REGENT          = Card.new('The Regent',          8,      %i[moons suns],         :personality)
  THE_ABBEY           = Card.new('The Abbey',           8,      %i[waves leaves],       :location)
  THE_DEFENESTRATION  = Card.new('The Defenestration',  8,      %i[wyrms knots],        :event)
  THE_ERUPTION        = Card.new('The Eruption',        9,      %i[moons suns],         :event)
  THE_STRAND          = Card.new('The Strand',          9,      %i[waves wyrms],        :location)
  THE_FARRIER         = Card.new('The Farrier',         9,      %i[leaves knots],       :personality)

  THE_FESTIVAL        = Card.new('The Festival',        :pawn,  %i[moons suns leaves],  :event)
  THE_NEMESIS         = Card.new('The Nemesis',         :pawn,  %i[moons wyrms knots],  :personality)
  THE_CONFIDANT       = Card.new('The Confidant',       :pawn,  %i[suns waves knots],   :personality)
  THE_STRANGER        = Card.new('The Stranger',        :court, %i[moons waves knots],  :personality)
  THE_DEPTHS          = Card.new('The Depths',          :pawn,  %i[waves leaves wyrms], :location)

  THE_REVERSAL        = Card.new('The Reversal',        :court, %i[moons leaves wyrms], :event)
  THE_SANCTUARY       = Card.new('The Sanctuary',       :court, %i[suns waves wyrms],   :location)
  THE_DRY_DOCK        = Card.new('The Dry Dock',        :court, %i[suns leaves knots],  :location)

  THE_SILVER_CROWN    = Card.new('The Silver Crown',    :crown, :moons,                 :personality)
  THE_AMBER_CROWN     = Card.new('The Amber Crown',     :crown, :suns,                  :personality)
  THE_SAPPHIRE_CROWN  = Card.new('The Sapphire Crown',  :crown, :waves,                 :location)
  THE_GARNET_CROWN    = Card.new('The Garnet Crown',    :crown, :leaves,                %i[location event])
  THE_EMERALD_CROWN   = Card.new('The Emerald Crown',   :crown, :wyrms,                 :event)
  THE_GOLDEN_CROWN    = Card.new('The Golden Crown',    :crown, :knots,                 :event)

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

  CAPITAL_CARDS = [
    THE_EXCUSE,
    THE_ACE_OF_MOONS, THE_ACE_OF_SUNS, THE_ACE_OF_WAVES, THE_ACE_OF_LEAVES, THE_ACE_OF_WYRMS, THE_ACE_OF_KNOTS,
    THE_SCULPTOR, THE_PILLORY, THE_MEMORY,                   # rank 2
    THE_BLIZZARD, THE_AUDITOR, THE_MOUNTEBANK,               # rank 3
    THE_GATE, THE_MILLER, THE_ARREST,                        # rank 4
    THE_GROVE, THE_APPOINTMENT, THE_ROGUE,                   # rank 5
    THE_NAVIGATOR, THE_HERMIT, THE_EXHIBITION,               # rank 6
    THE_FORTUITOUS_LOSS, THE_FORGE, THE_EYE,                 # rank 7
    THE_REGENT, THE_ABBEY, THE_DEFENESTRATION,               # rank 8
    THE_ERUPTION, THE_STRAND, THE_FARRIER,                   # rank 9
    THE_FESTIVAL, THE_NEMESIS, THE_CONFIDANT, THE_DEPTHS,    # pawns
    THE_STRANGER, THE_REVERSAL, THE_SANCTUARY, THE_DRY_DOCK, # courts
    THE_SILVER_CROWN, THE_AMBER_CROWN, THE_SAPPHIRE_CROWN, THE_GARNET_CROWN, THE_EMERALD_CROWN, THE_GOLDEN_CROWN
  ].freeze

  ACES                  = CARDS.select(&:ace?).freeze
  NUMBERS               = CARDS.select(&:number?).freeze
  PAWNS                 = CARDS.select(&:pawn?).freeze
  COURTS                = CARDS.select(&:court?).freeze
  CROWNS                = CARDS.select(&:crown?).freeze

  MOONS                 = CARDS.select(&:moons?).freeze
  SUNS                  = CARDS.select(&:suns?).freeze
  WAVES                 = CARDS.select(&:waves?).freeze
  LEAVES                = CARDS.select(&:leaves?).freeze
  WYRMS                 = CARDS.select(&:wyrms?).freeze
  KNOTS                 = CARDS.select(&:knots?).freeze

  LOCATIONS             = CARDS.select(&:location?).freeze
  PERSONALITIES         = CARDS.select(&:personality?).freeze
  EVENTS                = CARDS.select(&:event?).freeze

  CAPITAL_ACES          = CAPITAL_CARDS.select(&:ace?).freeze
  CAPITAL_NUMBERS       = CAPITAL_CARDS.select(&:number?).freeze
  CAPITAL_PAWNS         = CAPITAL_CARDS.select(&:pawn?).freeze
  CAPITAL_COURTS        = CAPITAL_CARDS.select(&:court?).freeze
  CAPITAL_CROWNS        = CAPITAL_CARDS.select(&:crown?).freeze

  CAPITAL_MOONS         = CAPITAL_CARDS.select(&:moons?).freeze
  CAPITAL_SUNS          = CAPITAL_CARDS.select(&:suns?).freeze
  CAPITAL_WAVES         = CAPITAL_CARDS.select(&:waves?).freeze
  CAPITAL_LEAVES        = CAPITAL_CARDS.select(&:leaves?).freeze
  CAPITAL_WYRMS         = CAPITAL_CARDS.select(&:wyrms?).freeze
  CAPITAL_KNOTS         = CAPITAL_CARDS.select(&:knots?).freeze

  CAPITAL_LOCATIONS     = CAPITAL_CARDS.select(&:location?).freeze
  CAPITAL_PERSONALITIES = CAPITAL_CARDS.select(&:personality?).freeze
  CAPITAL_EVENTS        = CAPITAL_CARDS.select(&:event?).freeze
end
