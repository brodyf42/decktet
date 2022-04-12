require 'spec_helper'

RSpec.describe Decktet::Card do
  let(:name) { 'the card' }
  let(:rank) { 2 }
  let(:suits) { [:moons, :suns] }
  let(:types) { [:location] }
  let(:card) { described_class.send(:new, name:, rank:, suits:, types:) }

  it 'cannot be directly instantiated' do
    expect { described_class.new(name:) }.to raise_error(NoMethodError) do |error|
      expect(error.message).to eq "private method `new' called for class Decktet::Card"
    end
  end

  describe '#excuse?' do
    subject { card.excuse? }

    context 'when attributes other than name are present' do
      it { should be false }
    end

    context 'when only the name is present' do
      let(:rank) { nil }
      let(:suits) { nil }
      let(:types) { nil }
      it { should be true }
    end
  end

  describe 'rank convenience methods' do
    named_ranks = Decktet::RANKS.select {|rank| Symbol === rank }

    it 'defines methods for each named rank' do
      named_ranks.each {|rank| expect(described_class.method_defined?("#{rank}?",false)).to be true }
    end

    named_ranks.each do |rank|
      method_name = "#{rank}?"
      describe "##{method_name}" do
        subject { card.public_send(method_name) }

        context "when the card has the #{rank} rank" do
          let(:rank) { rank }
          it { should be true }
        end

        context "when the card has a different rank that is not #{rank}" do
          let(:rank) { 3 }
          it { should be false }
        end

        context 'when the card has no rank' do
          let(:rank) { nil }
          it { should be false }
        end
      end
    end

    describe '#number?' do
      subject { card.number? }

      context "when the card has a number rank" do
        let(:rank) { 6 }
        it { should be true }
      end

      context "when the card has a rank that is not a number" do
        let(:rank) { :ace }
        it { should be false }
      end

      context 'when the card has no rank' do
        let(:rank) { nil }
        it { should be false }
      end
    end
  end

  describe 'suit convenience methods' do
    it 'defines methods for each suit' do
      Decktet::SUITS.each {|suit| expect(described_class.method_defined?("#{suit}?",false)).to be true }
    end

    it 'aliases suit methods as singular' do
      alias_map = {
        :moon? => :moons?,
        :sun? => :suns?,
        :wave? => :waves?,
        :leaf? => :leaves?,
        :wyrm? => :wyrms?,
        :knot? => :knots?,
      }

      alias_map.each do |alias_method,original_method|
        expect(card.method(alias_method).original_name).to eq original_method
      end
    end

    Decktet::SUITS.each do |suit|
      method_name = "#{suit}?"
      describe "##{method_name}" do
        subject { card.public_send method_name }

        context "when the card has the #{suit} suit" do
          let(:suits) { [suit] }
          it { should be true }
        end

        context "when the card has a different suit that is not #{suit}" do
          let(:suits) { Decktet::SUITS - [suit] }
          it { should be false }
        end

        context 'when the card has no suits' do
          let(:suits) { nil }
          it { should be false }
        end
      end
    end
  end

  describe 'type convenience methods' do
    it 'defines methods for each type' do
      Decktet::TYPES.each {|type| expect(described_class.method_defined?("#{type}?",false)).to be true }
    end

    Decktet::TYPES.each do |type|
      method_name = "#{type}?"
      describe "##{method_name}" do
        subject { card.public_send method_name }

        context "when the card has the #{type} type" do
          let(:types) { [type] }
          it { should be true }
        end

        context "when the card has a different type that is not #{type}" do
          let(:types) { Decktet::TYPES - [type] }
          it { should be false }
        end

        context 'when the card has no types' do
          let(:types) { nil }
          it { should be false }
        end
      end
    end
  end
end
