class Card
  attr_reader :name, :rank, :suits, :types

  SUITS = [:moons, :suns, :waves, :leaves, :wyrms, :knots]
  RANKS = [:ace] + Array(2..9) + [:pawn, :court, :crown]
  TYPES = [:location, :personality, :event]

  def initialize(name:, rank: nil, suits: nil, types: nil)
    validate_name(name)
    validate_rank(rank)
    validate_suits(suits)
    validate_types(types)
  end

  def excuse?
    rank.nil? && suits.nil? && types.nil?
  end

  def has_type?(type)
    return false if types.nil?
    types.include?(type)
  end

  def has_suit?(suit)
    return false if suits.nil?
    suits.include?(suit)
  end

  def moon?()  has_suit?(:moons)  end
  def sun?()   has_suit?(:suns)   end
  def wave?()  has_suit?(:waves)  end
  def leaf?()  has_suit?(:leaves) end
  def wyrm?()  has_suit?(:wyrms)  end
  def knot?()  has_suit?(:knots)  end

  private
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
