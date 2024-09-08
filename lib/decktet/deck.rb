module Decktet
  class Deck
    attr_reader :cards
    private_class_method :new

    class << self
      def available_templates
        TEMPLATES.keys
      end

      def new_deck_from_template(template)
        new(*TEMPLATES[template])
      end

      available_templates.each do |template|
        define method "new_#{template}" do
          new_deck_from_template(template)
        end
      end

      def new_custom_deck(*groups)
        new(*groups)
      end
    end

    def shuffle
      @cards.shuffle!
      self
    end

    def cut(depth: nil)
      unless depth.nil?
        raise ArgumentError.new('Invalid depth: value must be positive') if depth < 0
        raise ArgumentError.new('Invalid depth: cannot be greater than deck size') if depth > @cards.count
      end

      depth ||= rand(1...@cards.count)
      @cards.rotate!(depth)
      self
    end

    def draw(count = 1)
      @cards.shift(count)
    end

    private

    def initialize(*groups)
      unless groups.all?{|group| Card::CARD_GROUPS.keys.include? group}
        raise ArgumentError.new("A deck can only be initialized with the following defined groups: #{Card::CARD_GROUPS.keys}")
      end

      @cards = groups.map{|group| Card::CARD_GROUPS[group]}.flatten.map(&:dup)
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
