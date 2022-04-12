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

  def has_suit?(suit)
    return false if suits.nil?
    suits.include?(suit)
  end

  def has_type?(type)
    return false if types.nil?
    types.include?(type)
  end

  def is_excuse?
    rank.nil? && suits.nil? && types.nil?
  end

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
end
