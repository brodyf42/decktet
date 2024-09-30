module Decktet
  module CardCollection
    def shuffle
      card_collection.shuffle!
      self
    end

    def cut(depth=nil)
      return self if card_collection.empty?

      unless depth.nil?
        raise ArgumentError.new('cut depth cannot be negative') if depth < 0
        raise ArgumentError.new('cut depth cannot be greater than the number of cards') if depth > card_collection.count
      end

      depth ||= rand(1...card_collection.count)
      card_collection.rotate!(depth)
      self
    end

    def draw(count=1)
      unless count.between?(0,card_collection.count)
        raise ArgumentError.new('draw amount cannot be negative or greater than the number of cards')
      end
      card_collection.shift(count)
    end

    private

    def card_collection
      @cards ||= []
    end
  end
end
