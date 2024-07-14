require_relative '../spec_helper'

RSpec.describe Decktet::CardCollection do
  class TestClass
    include Decktet::CardCollection
    attr_reader :cards
    def initialize(cards)= @cards = cards
  end

  let(:cards) { Decktet::Card.cards_from_groups(:aces) }
  subject { TestClass.new(cards) }

  describe '#size' do
    it 'returns the number of cards in the collection' do
      expect(subject.size).to eq cards.count
    end

    context 'when the including class does not define' do
      let(:cards) { nil }

      it 'returns 0' do
        expect(subject.size).to eq 0
      end
    end
  end

  describe '#suffle' do
    it 'shuffles the cards' do
      expect(subject.cards).to receive(:shuffle!)
      subject.shuffle
    end

    it 'returns the class instance' do
      expect(subject.shuffle).to eq subject
    end
  end

  describe '#cut' do
    let(:depth) { 2 }

    context 'when the depth argument is negative' do
      let(:depth) { -2 }

      it 'raises an appropriate error' do
        expect{subject.cut(depth)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'cut depth cannot be negative'
        end
      end
    end

    context 'when the depth argument is larger than the cards collection' do
      let(:depth) { subject.cards.count + 2 }

      it 'raises an appropriate error' do
        expect{subject.cut(depth)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'cut depth cannot be greater than the number of cards'
        end
      end
    end

    it 'cuts the cards to the given depth' do
      expect(subject.cards).to receive(:rotate!).with(depth)
      subject.cut(depth)
    end

    it 'returns the class instance' do
      expect(subject.cut).to eq subject
    end
  end

  describe '#draw' do
    let(:count) { 2 }

    it 'returns an array of elements from the cards collection' do
      expect(subject.draw(count)).to eq [1,2]
    end

    it 'removes the drawn elements from the cards collection' do
      subject.draw(count)
      expect(subject.cards).to eq [3,4,5]
    end

    context 'when called without an argument' do
      it 'returns a single element array' do
        expect(subject.draw.count).to eq 1
      end
    end

    context 'when called with a negative number' do
      let(:count) { -2 }

      it 'raises an appropriate error' do
        expect{subject.draw(count)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'draw amount cannot be negative or greater than the number of cards'
        end
      end
    end

    context 'when called with a number greater than the size of the card collection' do
      let(:count) { subject.cards.count + 2 }

      it 'raises an appropriate error' do
        expect{subject.draw(count)}.to raise_error(ArgumentError) do |error|
          expect(error.message).to eq 'draw amount cannot be negative or greater than the number of cards'
        end
      end
    end
  end

  describe '#add' do
    let(:new_cards) { Decktet::Card.cards_from_groups(:pawns) }

    it 'returns the class instance' do
      expect(subject.add(new_cards)).to eq subject
    end

    it 'allows a single card to be added' do
      subject.add(new_cards.first)
      expect(subject.cards).to include(new_cards)
    end

    it 'allows an array of cards to be added' do
      subject.add(new_cards)
      expect(subject.cards).to include(new_cards)
    end

    context 'when the elements being added are not a Decktet::Card objects' do
      let(:new_cards) { 'ace-of-spades' }

      it 'raises an exception with an appropriate message' do
        expect{ subject.add(new_cards) }.to raise_exception ArgumentError do |e|
          expect(e.message).to match /Only Decktet::Card objects can be added to a TestClass/
        end
      end
    end
  end
end
