module Decktet
  class Deck < Pile
    include Decktet::CardCollection

    attr_reader :cards

    module Templates
      BASIC_DECK =  [Card::ACES, Card::NUMBER_CARDS, Card::CROWNS].flatten
      BASIC_DECK_WITH_EXCUSE = [Card::THE_EXCUSE] + BASIC_DECK
      EXTENDED_DECK = BASIC_DECK_WITH_EXCUSE + [Card::PAWNS, Card::COURTS].flatten
      DOUBLE_DECK = BASIC_DECK + BASIC_DECK
    end

    def initialize(*cards)
      @cards = cards.flatten

      unless @cards.all?{|card| Decktet::Card === card }
        raise ArgumentError.new("A deck can only be initialized with Decktet::Card objects. Deck templates defined in Decktet::Deck::Templates and card groups or specific cards defined in Decktet::Card are accepted.")
      end
    end
  end
end
