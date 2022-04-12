module Decktet
  class Pile
    def initialize(*cards)
      @cards = cards.flatten.compact

      unless cards.empty? || @cards.all? { |card| Decktet::Card === card }
        raise ArgumentError.new('A pile must be initialized empty or with an array of cards or card groups')
      end
    end

    def cards = @cards.dup

    def size = @cards.size

    def shuffle
      @cards.shuffle!
      self
    end

    def cut(depth=nil)
      return self if @cards.empty?

      unless depth.nil?
        raise ArgumentError.new('cut depth cannot be negative') if depth < 0
        raise ArgumentError.new('cut depth cannot be greater than the number of cards') if depth > @cards.count
      end

      depth ||= rand(1...@cards.count)
      @cards.rotate!(depth)
      self
    end

    def draw(count=1)
      unless count.between?(0,@cards.count)
        raise ArgumentError.new('draw amount cannot be negative or greater than the number of cards')
      end
      @cards.shift(count)
    end

    def add(*new_cards)
      new_cards = new_cards.flatten
      unless new_cards.all? { |card| Decktet::Card === card }
        raise ArgumentError, "Only Decktet::Card objects can be added to a #{self.class.name}"
      end
      @cards.unshift(*new_cards)
      self
    end
  end
end
