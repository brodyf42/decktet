require 'spec_helper'

RSpec.describe Card do
  let(:name) { 'the card' }
  let(:rank) { 2 }
  let(:suits) { [:moons, :suns] }
  let(:types) { [:location] }
  subject { described_class.new(name: name, rank: rank, suits: suits, types: types) }

  describe 'Creating a card' do
    it 'successfully creates a Card object' do
      expect(subject).to be_a(Card)
    end

    shared_examples 'passing an invalid argument' do
      it 'raises an ArgumentError with a useful message' do
        expect{subject}.to raise_error(ArgumentError, message)
      end
    end

    describe 'name validation' do
      context 'name is not a string' do
        let(:name) { 5 }
        let(:message) { 'name must be a String' }
        it_behaves_like 'passing an invalid argument'
      end

      context 'when name is an empty string' do
        let(:name) { '' }
        let(:message) { 'name must have length > 0' }
        it_behaves_like 'passing an invalid argument'
      end
    end

    describe 'rank validation' do
      context 'when rank is not a valid value' do
        let(:rank) { :jack }
        let(:message) { 'rank must be nil or one of the following values: [:ace, 2, 3, 4, 5, 6, 7, 8, 9, :pawn, :court, :crown]' }
        it_behaves_like 'passing an invalid argument'
      end
    end

    describe 'suits validation' do
      shared_examples 'passing bad suits data' do
        let(:message) { 'suits must be nil or an array of one or more suit symbols in the following list: [:moons, :suns, :waves, :leaves, :wyrms, :knots]' }
        it_behaves_like 'passing an invalid argument'
      end

      context 'when suits is not an array' do
        let(:suits) { :moons }
        it_behaves_like 'passing bad suits data'
      end

      context 'when the array is empty' do
        let(:suits) { [] }
        it_behaves_like 'passing bad suits data'
      end

      context 'when an invalid value is present' do
        let(:suits) { [:clubs] }
        it_behaves_like 'passing bad suits data'
      end

      context 'when a value is duplicated' do
        let(:suits) { [:moons, :suns, :moons] }
        let(:message) { 'duplicate suits are not allowed' }
        it_behaves_like 'passing an invalid argument'
      end
    end

    describe 'types validation' do
      shared_examples 'passing bad types data' do
        let(:message) { 'types must be nil or an array of one or more type symbols in the following list: [:location, :personality, :event]' }
        it_behaves_like 'passing an invalid argument'
      end

      context 'when types is not an array' do
        let(:types) { 0 }
        it_behaves_like 'passing bad types data'
      end

      context 'when the array is empty' do
        let(:types) { [] }
        it_behaves_like 'passing bad types data'
      end

      context 'when an invalid value is present' do
        let(:types) { [:face_card] }
        it_behaves_like 'passing bad types data'
      end

      context 'when a value is duplicated' do
        let(:types) { [:location, :event, :event] }
        let(:message) { 'duplicate types are not allowed' }
        it_behaves_like 'passing an invalid argument'
      end
    end
  end

  describe '#excuse?' do
    context 'when instantiating a normal card' do
      it 'returns false' do
        expect(subject.excuse?).to be false
      end
    end

    context 'when only the name is present' do
      let(:rank) { nil }
      let(:suits) { nil }
      let(:types) { nil }
      it 'returns true' do
        expect(subject.excuse?).to be true
      end
    end

    context 'when only the name is provided on instantiation' do
      subject { Card.new(name: name) }
      it 'returns true' do
        expect(subject.excuse?).to be true
      end
    end
  end

  describe '#has_type?' do
    let(:query_type) { :location }

    context 'when the card has the given type' do
      let(:types) { [:location] }
      it 'returns true' do
        expect(subject.has_type?(query_type)).to be true
      end
    end

    context 'when the card does not have the given type' do
      let(:types) { [:personality] }
      it 'returns false' do
        expect(subject.has_type?(query_type)).to be false
      end
    end

    context 'when types is nil' do
      let(:types) { nil }
      it 'returns false' do
        expect(subject.has_type?(query_type)).to be false
      end
    end
  end

  describe '#has_suit?' do
    let(:query_suit) { :moons }

    context 'when the card has the given suit' do
      let(:suits) { [:moons, :suns] }
      it 'returns true' do
        expect(subject.has_suit?(query_suit)).to be true
      end
    end

    context 'when the card does not have the given suit' do
      let(:suits) { [:waves, :wyrms] }
      it 'returns false' do
        expect(subject.has_suit?(query_suit)).to be false
      end
    end

    context 'when suits is nil' do
      let(:suits) { nil }
      it 'returns false' do
        expect(subject.has_suit?(query_suit)).to be false
      end
    end
  end

  describe 'suit convenience methods' do
    [ {name: :moon?, suit: :moons},
      {name: :sun?, suit: :suns},
      {name: :wave?, suit: :waves},
      {name: :leaf?, suit: :leaves},
      {name: :wyrm?, suit: :wyrms},
      {name: :knot?, suit: :knots},
    ].each do |suit_method|
      describe "##{suit_method[:name]}" do

        context "when the card has the #{suit_method[:suit]} suit" do
          let(:suits) { [suit_method[:suit]] }

          it 'returns true' do
            expect(subject.public_send(suit_method[:name])).to eq true
          end
        end

        context "when the card has a different suit that is not #{suit_method[:suit]}" do
          let(:suits) { Card::SUITS - [suit_method[:suit]] }

          it 'returns false' do
            expect(subject.public_send(suit_method[:name])).to eq false
          end
        end

        context 'when the card has no suits' do
          let(:suits) { nil }

          it 'returns false' do
            expect(subject.public_send(suit_method[:name])).to eq false
          end
        end
      end
    end
  end
end
