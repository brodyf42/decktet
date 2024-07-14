require 'spec_helper'

RSpec.describe Decktet::Card do
  let(:name) { 'the card' }
  let(:rank) { 2 }
  let(:suits) { [:moons, :suns] }
  let(:types) { [:location] }
  subject { described_class.send(:new, name: name, rank: rank, suits: suits, types: types) }

  it 'does not allow direct instantiation' do
    expect{ described_class.new(name: name) }.to raise_exception NoMethodError do |e|
      expect(e.message).to match /private method `new' called for #{described_class}/
    end
  end

  describe '#excuse?' do
    context 'when attributes other than name are present' do
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
  end

  describe 'rank convenience methods' do
    named_ranks = described_class::RANKS - Array(2..9)

    it 'defines methods for each named rank' do
      named_ranks.each {|rank| expect(described_class.method_defined?("#{rank}?",false)).to be true }
    end

    named_ranks.each do |rank|
      method_name = "#{rank}?"
      describe "##{method_name}" do
        context "when the card has the #{rank} rank" do
          let(:rank) { rank }

          it 'returns true' do
            expect(subject.public_send(method_name)).to be true
          end
        end

        context "when the card has a different rank that is not #{rank}" do
          let(:rank) { 3 }

          it 'returns false' do
            expect(subject.public_send(method_name)).to eq false
          end
        end

        context 'when the card has no rank' do
          let(:rank) { nil }

          it 'returns false' do
            expect(subject.public_send(method_name)).to eq false
          end
        end
      end
    end
  end

  describe 'suit convenience methods' do
    it 'defines methods for each suit' do
      described_class::SUITS.each {|suit| expect(described_class.method_defined?("#{suit}?",false)).to be true }
    end

    described_class::SUITS.each do |suit|
      method_name = "#{suit}?"
      describe "##{method_name}" do

        context "when the card has the #{suit} suit" do
          let(:suits) { [suit] }

          it 'returns true' do
            expect(subject.public_send(method_name)).to be true
          end
        end

        context "when the card has a different suit that is not #{suit}" do
          let(:suits) { described_class::SUITS - [suit] }

          it 'returns false' do
            expect(subject.public_send(method_name)).to eq false
          end
        end

        context 'when the card has no suits' do
          let(:suits) { nil }

          it 'returns false' do
            expect(subject.public_send(method_name)).to eq false
          end
        end
      end
    end
  end

  describe 'type convenience methods' do
    it 'defines methods for each type' do
      described_class::TYPES.each {|type| expect(described_class.method_defined?("#{type}?",false)).to be true }
    end

    described_class::TYPES.each do |type|
      method_name = "#{type}?"
      describe "##{method_name}" do

        context "when the card has the #{type} type" do
          let(:types) { [type] }

          it 'returns true' do
            expect(subject.public_send(method_name)).to be true
          end
        end

        context "when the card has a different type that is not #{type}" do
          let(:types) { described_class::TYPES - [type] }

          it 'returns false' do
            expect(subject.public_send(method_name)).to eq false
          end
        end

        context 'when the card has no types' do
          let(:types) { nil }

          it 'returns false' do
            expect(subject.public_send(method_name)).to eq false
          end
        end
      end
    end
  end
end
