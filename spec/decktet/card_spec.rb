require 'rspec'

RSpec.describe Card do
  let(:name) { 'the card' }
  let(:rank) { 2 }
  let(:suits) { [:moons, :suns] }
  let(:types) { [:location] }
  subject(:card) { Card.new(name: name, rank: rank, suits: suits, types: types) }

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
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'name must be a String' }
        end
      end

      context 'when name is an empty string' do
        let(:name) { '' }
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'name must have length > 0' }
        end
      end
    end

    describe 'rank validation' do
      context 'when rank is not a valid value' do
        let(:rank) { :jack }
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'rank must be nil or one of the following values: [:ace, 2, 3, 4, 5, 6, 7, 8, 9, :pawn, :court, :crown]' }
        end
      end
    end

    describe 'suits validation' do
      shared_examples 'passing bad suits data' do
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'suits must be nil or an array of one or more suit symbols in the following list: [:moons, :suns, :waves, :leaves, :wyrms, :knots]' }
        end
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
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'duplicate suits are not allowed' }
        end
      end
    end

    describe 'types validation' do
      shared_examples 'passing bad types data' do
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'types must be nil or an array of one or more type symbols in the following list: [:location, :personality, :event]' }
        end
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
        it_behaves_like 'passing an invalid argument' do
          let(:message) { 'duplicate types are not allowed' }
        end
      end
    end
  end

  describe '#has_suit?' do
    let(:query_suit) { :moons }

    context 'when the card has the given suit' do
      it 'returns true' do
        expect(card.has_suit?(query_suit)).to be true
      end
    end

    context 'when the card does not have the given suit' do
      let(:suits) { [:waves, :wyrms] }
      it 'returns false' do
        expect(card.has_suit?(query_suit)).to be false
      end
    end

    context 'when suits is nil' do
      let(:suits) { nil }
      it 'returns false' do
        expect(card.has_suit?(query_suit)).to be false
      end
    end
  end

  describe '#has_type?' do
    let(:query_type) { :location }

    context 'when the card has the given type' do
      it 'returns true' do
        expect(card.has_type?(query_type)).to be true
      end
    end

    context 'when the card does not have the given type' do
      let(:types) { [:personality] }
      it 'returns false' do
        expect(card.has_type?(query_type)).to be false
      end
    end

    context 'when types is nil' do
      let(:types) { nil }
      it 'returns false' do
        expect(card.has_type?(query_type)).to be false
      end
    end
  end

  describe '#is_excuse?' do
    context 'when instantiating a normal card' do
      it 'returns false' do
        expect(card.is_excuse?).to be false
      end
    end

    context 'when only the name is present' do
      let(:rank) { nil }
      let(:suits) { nil }
      let(:types) { nil }
      it 'returns true' do
        expect(card.is_excuse?).to be true
      end
    end

    context 'when only the name is provided on instantiation' do
      subject(:card) { Card.new(name: name) }
      it 'returns true' do
        expect(card.is_excuse?).to be true
      end
    end
  end
end
