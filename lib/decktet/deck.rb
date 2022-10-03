class Deck
  attr_reader :cards

  def initialize(cards)
    raise ArgumentError.new('A deck can only be initialized with an array of Cards') unless cards.is_a?(Array) && cards.all?{|c| c.is_a?(Card)}
    @cards = cards
  end

  def shuffle
    cards.shuffle!
    self
  end
end
