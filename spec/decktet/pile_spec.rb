require_relative '../spec_helper'

RSpec.describe Decktet::Pile do
  let(:cards) { Decktet::ACES }
  subject { described_class.new(cards) }

  describe 'instantiation' do
    context 'when instantiated with an empty set' do
      let(:cards) { [] }

      it 'should not raise an error' do
        expect{subject}.not_to raise_error
      end

      it 'should have an empty card list' do
        expect(subject.cards).to be_empty
      end
    end

    context 'when instantiated a nil value' do
      let(:cards) { nil }

      it 'should not raise an error' do
        expect{subject}.not_to raise_error
      end

      it 'should have an empty card list' do
        expect(subject.cards).to be_empty
      end
    end

    context 'when instantiated a collection containing incorrect types' do
      let(:cards) { [1,2,3] }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'A pile must be initialized empty or with an array of cards or card groups'
        end
      end
    end

    context 'when instantiated an incorrect type' do
      let(:cards) { 'some-string' }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'A pile must be initialized empty or with an array of cards or card groups'
        end
      end
    end

    context 'when instantiated with a card group' do
      let(:cards) { Decktet::NUMBERS }

      it 'includes only cards from that group' do
        expect(subject.cards).to match_array cards
      end
    end

    context 'when instantiated with a single card' do
      let(:cards) { Decktet::THE_BARD }

      it 'includes only that cards' do
        expect(subject.cards).to match_array cards
      end
    end

    context 'when instantiated with a mix of card groups and single cards' do
      let(:cards) { [Decktet::NUMBERS, Decktet::THE_EXCUSE, Decktet::THE_AUTHOR, Decktet::CROWNS] }

      it 'includes all provided cards in a single collection' do
        expect(subject.cards).to match_array cards.flatten
      end
    end
  end

  describe '#cards' do
    it 'returns an array including all cards in the card collection' do
      expect(subject.cards).to match_array cards
    end

    it 'does not allow manipulation of the internal card collection' do
      expect{ subject.cards.shift }.not_to change{ subject.size }
    end
  end

  describe '#size' do
    it 'returns the number of cards in the collection' do
      expect(subject.size).to eq cards.count
    end

    context 'when created without cards' do
      let(:cards) { nil }

      it 'returns 0' do
        expect(subject.size).to eq 0
      end
    end
  end

  describe '#shuffle' do
    let(:card_collection) { subject.instance_variable_get :@cards }

    it 'shuffles the cards' do
      expect(card_collection).to receive(:shuffle!)
      expect(subject.cards).to match_array cards
      subject.shuffle
    end

    it 'returns self' do
      expect(subject.shuffle).to eq subject
    end
  end

  describe '#cut' do
    let(:depth) { 2 }
    let(:card_collection) { subject.instance_variable_get :@cards }

    context 'when the depth argument is negative' do
      let(:depth) { -2 }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject.cut(depth)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'cut depth cannot be negative'
        end
      end
    end

    context 'when the depth argument is larger than the cards collection' do
      let(:depth) { subject.cards.count + 2 }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject.cut(depth)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'cut depth cannot be greater than the number of cards'
        end
      end
    end

    it 'cuts the cards to the given depth' do
      expect(card_collection).to receive(:rotate!).with(depth)
      subject.cut(depth)
    end

    it 'returns self' do
      expect(subject.cut).to eq subject
    end
  end

  describe '#draw' do
    let(:count) { 2 }

    it 'returns an array of elements from the cards collection' do
      expect(subject.draw(count)).to eq [Decktet::THE_ACE_OF_MOONS, Decktet::THE_ACE_OF_SUNS]
    end

    it 'removes the drawn elements from the cards collection' do
      expect{ subject.draw(count) }.to change{ subject.size }.by(-2)
      expect(subject.cards).to eq Decktet::ACES[count..]
    end

    context 'when called without an argument' do
      it 'returns a single element array' do
        expect(subject.draw.count).to eq 1
      end
    end

    context 'when called with a negative number' do
      let(:count) { -2 }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject.draw(count)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'draw amount cannot be negative or greater than the number of cards'
        end
      end
    end

    context 'when called with a number greater than the size of the card collection' do
      let(:count) { subject.cards.count + 2 }

      it 'raises an ArgumentError with an appropriate message' do
        expect{subject.draw(count)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'draw amount cannot be negative or greater than the number of cards'
        end
      end
    end
  end

  describe '#add' do
    let(:new_cards) { Decktet::PAWNS }

    it 'returns self' do
      expect(subject.add(new_cards)).to eq subject
    end

    it 'allows a single card to be added' do
      subject.add(new_cards.first)
      expect(subject.cards).to include(new_cards.first)
    end

    it 'allows an array of cards to be added' do
      subject.add(new_cards)
      expect(subject.cards).to include(*new_cards)
    end

    context 'when the elements being added are not a Decktet::Card objects' do
      let(:new_cards) { 'ace-of-spades' }

      it 'raises an exception with an appropriate message' do
        expect{ subject.add(new_cards) }.to raise_exception ArgumentError do |e|
          expect(e.message).to match /Only Decktet::Card objects can be added to a #{described_class.name}/
        end
      end
    end
  end
end
