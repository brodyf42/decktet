require_relative '../spec_helper'

RSpec.describe Decktet::Deck do
  let(:cards) { Decktet::NUMBERS }
  subject { described_class.new cards }

  it 'is a subclass of Decktet::Pile' do
    expect(subject).to be_a Decktet::Pile
  end

  it 'defines methods for deck templates' do
    %w[new_basic_deck new_basic_deck_with_excuse new_extended_deck new_double_deck].each do |method_name|
      expect(Decktet::Deck.respond_to? method_name).to be true
    end
  end

  describe 'instantiation' do
    context 'when instantiated with an empty set' do
      let(:cards) { [] }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'A deck can only be initialized with Decktet::Card objects. Deck templates defined in Decktet::DeckTemplates and card groups or specific cards are accepted.'
        end
      end
    end

    context 'when instantiated a nil value' do
      let(:cards) { nil }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'A deck can only be initialized with Decktet::Card objects. Deck templates defined in Decktet::DeckTemplates and card groups or specific cards are accepted.'
        end
      end
    end

    context 'when instantiated with a template method' do
      subject { described_class.new_extended_deck }

      it 'includes all cards defined in the associated constant' do
        expect(subject.cards).to match_array Decktet::DeckTemplates::EXTENDED_DECK.flatten
      end
    end
  end
end