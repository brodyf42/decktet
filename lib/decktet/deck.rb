module Decktet
  class Deck
    include Decktet::CardCollection

    attr_reader :cards
    private_class_method :new

    class << self
      def available_templates
        TEMPLATES.keys
      end

      def new_deck_from_template(template)
        new(*TEMPLATES[template])
      end

      def new_custom_deck(*groups)
        new(*groups)
      end
    end

    private

    def initialize(*groups)

      puts "groups: #{groups}"
      unless groups.all?{|group| Decktet::Card.available_groups.include? group}
        raise ArgumentError.new("A deck can only be initialized with the following defined groups: #{Decktet::Card.available_groups}")
      end

      @cards = Decktet::Card.cards_from_groups(*groups)
    end

    TEMPLATES = {
      basic_deck: [:aces, :number_cards, :crowns],
      extended_deck: [:the_excuse, :aces, :number_cards, :pawms, :courts, :crowns],
      double_deck: [:aces,:aces, :number_cards, :number_cards, :crowns, :crowns],
      basic_deck_with_excuse: [:the_excuse, :aces, :number_cards, :crowns]
    }

    private_constant :TEMPLATES
  end
end
