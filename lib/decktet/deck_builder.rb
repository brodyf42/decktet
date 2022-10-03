require_relative 'card'
require_relative 'deck'

class DeckBuilder
  def self.new_standard_deck
    Deck.new(card_list_for(Card::ACES) + card_list_for(Card::NUMBER_CARDS) + card_list_for(Card::CROWNS))
  end

  private
  def self.card_list_for(options_list)
    options_list.map{ |options| Card.new(**options) }
  end
end
