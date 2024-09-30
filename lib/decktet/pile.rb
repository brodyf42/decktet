module Decktet
  class Pile
    include Decktet::CardCollection

    attr_reader :cards

    def initialize(cards=nil)
      unless cards.nil? || [*cards].all? { |c| Decktet::Card === c }
        raise ArgumentError.new("A pile must be initialized empty or with an array of cards")
      end

      @cards = [*cards]
    end
  end
end
