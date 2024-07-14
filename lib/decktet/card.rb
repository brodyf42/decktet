module Decktet
  class Card
    attr_reader :name, :rank, :suits, :types
    private_class_method :new

    SUITS = [:moons, :suns, :waves, :leaves, :wyrms, :knots]
    RANKS = [:ace] + Array(2..9) + [:pawn, :court, :crown]
    TYPES = [:location, :personality, :event]

    def excuse?
      rank.nil? && suits.nil? && types.nil?
    end

    SUITS.each { |suit| define_method(:"#{suit}?") { suits&.include?(suit) || false } }
    RANKS.each { |rank| define_method(:"#{rank}?") { self.rank == rank  } }
    TYPES.each { |type| define_method(:"#{type}?") { types&.include?(type) || false } }

    def to_h
      {name: name, rank: rank, suits: suits, types: types}
    end

    private

    def initialize(name:, rank: nil, suits: nil, types: nil)
      validate_name(name)
      validate_rank(rank)
      validate_suits(suits)
      validate_types(types)
    end

    def validate_name(name)
      raise ArgumentError.new('name must be a String') unless name.is_a?(String)
      raise ArgumentError.new('name must have length > 0') if name.empty?
      @name = name
    end

    def validate_rank(rank)
      raise ArgumentError.new("rank must be nil or one of the following values: #{RANKS}") unless rank.nil? || RANKS.include?(rank)
      @rank = rank
    end

    def validate_suits(suits)
      unless suits.nil? || (suits.is_a?(Array) && suits.length > 0 && suits.all?{|s| SUITS.include?(s)})
        raise ArgumentError.new("suits must be nil or an array of one or more suit symbols in the following list: #{SUITS}")
      end
      raise ArgumentError.new("duplicate suits are not allowed") unless suits.nil? || suits.uniq!.nil?
      @suits = suits
    end

    def validate_types(types)
      unless types.nil? || (types.is_a?(Array) && types.length > 0 && types.all?{|t| TYPES.include?(t)})
        raise ArgumentError.new("types must be nil or an array of one or more type symbols in the following list: #{TYPES}")
      end
      raise ArgumentError.new("duplicate types are not allowed") unless types.nil? || types.uniq!.nil?
      @types = types
    end

    THE_EXCUSE = new(name: 'the EXCUSE')

    ACES = [
      new(name: 'the ACE of MOONS',  rank: :ace, suits: [:moons]),
      new(name: 'the ACE of SUNS',   rank: :ace, suits: [:suns]),
      new(name: 'the ACE of WAVES',  rank: :ace, suits: [:waves]),
      new(name: 'the ACE of LEAVES', rank: :ace, suits: [:leaves]),
      new(name: 'the ACE of WYRMS',  rank: :ace, suits: [:wyrms]),
      new(name: 'the ACE of KNOTS',  rank: :ace, suits: [:knots])
    ]

    NUMBER_CARDS = [
      new(name: 'the AUTHOR',         rank: 2, suits: [:moons, :knots],  types: [:personality]),
      new(name: 'the DESERT',         rank: 2, suits: [:suns, :wyrms],   types: [:location]),
      new(name: 'the ORIGIN',         rank: 2, suits: [:waves, :leaves], types: [:location, :event]),
      new(name: 'the JOURNEY',        rank: 3, suits: [:moons, :waves],  types: [:event]),
      new(name: 'the PAINTER',        rank: 3, suits: [:suns, :knots],   types: [:personality]),
      new(name: 'the SAVAGE',         rank: 3, suits: [:leaves, :wyrms], types: [:personality]),
      new(name: 'the MOUNTAIN',       rank: 4, suits: [:moons, :suns],   types: [:location]),
      new(name: 'the SAILOR',         rank: 4, suits: [:waves, :leaves], types: [:personality]),
      new(name: 'the BATTLE',         rank: 4, suits: [:wyrms, :knots],  types: [:event]),
      new(name: 'the FOREST',         rank: 5, suits: [:moons, :leaves], types: [:location]),
      new(name: 'the DISCOVERY',      rank: 5, suits: [:suns, :waves],   types: [:event]),
      new(name: 'the SOLDIER',        rank: 5, suits: [:wyrms, :knots],  types: [:personality]),
      new(name: 'the LUNATIC',        rank: 6, suits: [:moons, :waves],  types: [:personality]),
      new(name: 'the PENITENT',       rank: 6, suits: [:suns, :wyrms],   types: [:personality]),
      new(name: 'the MARKET',         rank: 6, suits: [:leaves, :knots], types: [:location, :event]),
      new(name: 'the CHANCE MEETING', rank: 7, suits: [:moons, :leaves], types: [:event]),
      new(name: 'the CASTLE',         rank: 7, suits: [:suns, :knots],   types: [:location]),
      new(name: 'the CAVE',           rank: 7, suits: [:waves, :wyrms],  types: [:location]),
      new(name: 'the DIPLOMAT',       rank: 8, suits: [:moons, :suns],   types: [:personality]),
      new(name: 'the MILL',           rank: 8, suits: [:waves, :leaves], types: [:location]),
      new(name: 'the BETRAYAL',       rank: 8, suits: [:wyrms, :knots],  types: [:event]),
      new(name: 'the PACT',           rank: 9, suits: [:moons, :suns],   types: [:event]),
      new(name: 'the DARKNESS',       rank: 9, suits: [:waves, :wyrms],  types: [:location]),
      new(name: 'the MERCHANT',       rank: 9, suits: [:leaves, :knots], types: [:personality])
    ]

    PAWNS = [
      new(name: 'the HARVEST',      rank: :pawn, suits: [:moons, :suns, :leaves],  types: [:event]),
      new(name: 'the WATCHMAN',     rank: :pawn, suits: [:moons, :wyrms, :knots],  types: [:personality]),
      new(name: 'the LIGHT KEEPER', rank: :pawn, suits: [:suns, :waves, :knots],   types: [:personality]),
      new(name: 'the BORDERLAND',   rank: :pawn, suits: [:waves, :leaves, :wyrms], types: [:location])
    ]

    COURTS = [
      new(name: 'the CONSUL', rank: :court, suits: [:moons, :waves, :knots],  types: [:personality]),
      new(name: 'the RITE',   rank: :court, suits: [:moons, :leaves, :wyrms], types: [:event]),
      new(name: 'the ISLAND', rank: :court, suits: [:suns, :waves, :wyrms],   types: [:location]),
      new(name: 'the WINDOW', rank: :court, suits: [:suns, :leaves, :knots],  types: [:location])
    ]

    CROWNS = [
      new(name: 'the HUNTRESS', rank: :crown, suits: [:moons],  types: [:personality]),
      new(name: 'the BARD',     rank: :crown, suits: [:suns],   types: [:personality]),
      new(name: 'the SEA',      rank: :crown, suits: [:waves],  types: [:location]),
      new(name: 'the END',      rank: :crown, suits: [:leaves], types: [:location, :event]),
      new(name: 'the CALAMITY', rank: :crown, suits: [:wyrms],  types: [:event]),
      new(name: 'the WINDFALL', rank: :crown, suits: [:knots],  types: [:event])
    ]

    CARD_GROUPS = {
      the_excuse: THE_EXCUSE,
      aces: ACES,
      number_cards: NUMBER_CARDS,
      pawns: PAWNS,
      courts: COURTS,
      crowns: CROWNS
    }

    private_constant :THE_EXCUSE
    private_constant :ACES
    private_constant :NUMBER_CARDS
    private_constant :PAWNS
    private_constant :COURTS
    private_constant :CROWNS
  end
end
