module Decktet
  module DeckTemplates
    BASIC_DECK =  [ACES, NUMBERS, CROWNS].flatten
    BASIC_DECK_WITH_EXCUSE = [THE_EXCUSE] + BASIC_DECK
    EXTENDED_DECK = BASIC_DECK_WITH_EXCUSE + [PAWNS, COURTS].flatten
    DOUBLE_DECK = BASIC_DECK + BASIC_DECK

    BASIC_CAPITAL_DECK =  [CAPITAL_ACES, CAPITAL_NUMBERS, CAPITAL_CROWNS].flatten
    BASIC_CAPITAL_DECK_WITH_EXCUSE = [THE_EXCUSE] + BASIC_CAPITAL_DECK
    EXTENDED_CAPITAL_DECK = BASIC_CAPITAL_DECK_WITH_EXCUSE + [CAPITAL_PAWNS, CAPITAL_COURTS].flatten
    DOUBLE_CAPITAL_DECK = BASIC_CAPITAL_DECK + BASIC_CAPITAL_DECK

    COMBINED_DOUBLE_DECK = BASIC_DECK + BASIC_CAPITAL_DECK
  end

  class Deck < Pile
    def initialize(*cards)
      @cards = cards.flatten

      unless @cards.any? && @cards.all?{|card| Decktet::Card === card }
        raise ArgumentError.new("A deck can only be initialized with Decktet::Card objects. Deck templates defined in Decktet::DeckTemplates and card groups or specific cards are accepted.")
      end
    end

    class << self
      DeckTemplates.constants.each do |template|
        define_method("new_#{template}".downcase) { new DeckTemplates.const_get(template) }
      end
    end
  end
end
