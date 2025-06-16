# Decktet

[![Gem Version](https://badge.fury.io/rb/decktet.svg?icon=si%3Arubygems)](https://rubygems.org/gems/decktet)

This gem provides a basic interface to the Decktet playing card system. Visit [decktet.com](https://www.decktet.com/) for an overview of the Decktet. More detailed information, including many games that can be played with this unique deck, can be found on [The Decktet Wiki](http://decktet.wikidot.com/). This gem is meant as a core library for manipulating the elements of the Decktet itself. As such, it does not include any game engine or other such advanced functionality.  

## Getting Started

Include `decktet` in your application's Gemfile:

```ruby
gem 'decktet'
```

Then run `bundle install`.

Alternatively, you can install it manually by running `gem install decktet`.

## Usage

The decktet gem provides 3 classes: `Decktet::Card`, `Decktet::Deck`, and `Decktet::Pile`

A general use case includes creating a new `Decktet::Deck` and moving cards between the deck and various piles.

Here is an example of a simple game setup:

```ruby
deck = Decktet::Deck.new_basic_deck
deck.shuffle

player1_hand = deck.draw 3
player2_hand = deck.draw 3

discard_pile = Decktet::Pile.new(deck.draw)
```

### Card

The `Decktet::Card` class is an immutable data container that provides some convenience methods for accessing card information.

All of the cards in the extended deck are defined by top-level constants in the `Decktet` namespace.  Additional constants are defined for specific groups of cards based on card attributes, such as `Decktet::ACES`, `Decktet::MOONS`, and `Decktet::PERSONALITIES`.

```ruby
card = Decktet::THE_SAVAGE
card.name    # => "the SAVAGE"
card.excuse? # => false

card.rank    # => 3
card.number? # => true
card.ace?    # => false

card.suits   # => [:leaves, :wyrms]
card.leaves? # => true
card.leaf?   # => true
card.moons?  # => false

card.types        # => [:personality]
card.personality? # => true
card.location?    # => false
```

### Pile

The `Decktet::Pile` class defines a collection of cards that can be manipulated. 
#### Instantiation

A pile can be instantiated with any number of `Decktet::Card` objects or empty. Any combination of cards, card groups, and deck templates are valid arguments for instantiation. 

```ruby
p1 = Decktet::Pile.new
p2 = Decktet::Pile.new(Decktet::THE_ACE_OF_MOONS)
p3 = Decktet::Pile.new(Decktet::ACES, Decktet::CROWNS)
p4 = Decktet::Pile.new(Decktet::DeckTemplates::BASIC_DECK, Decktet::PAWNS, Decktet::THE_EXCUSE)
```

#### Methods

The `cards` method returns a duplicated array of all cards currently in the pile. Any operations on the return value of this method that would alter it in some way will have no effect on the collection of cards managed internally by the pile object. 

The `size` method returns the count of cards in the pile.

The `shuffle` method randomizes the order of cards in the pile. This method returns `self`.

The `cut` method will move some number of cards from the top of the pile to the bottom of the pile, preserving order. This method accepts an argument indicating the number of cards to move. If no argument is provided, the number of cards moved will be randomly selected. This method returns `self`. 

The `draw` method removes some number of cards from the pile and returns them in an array. This method accepts an argument indicating the number of cards to draw. If no argument is provided, one card wil be drawn.

The `add` method places cards on the pile. This method accepts any number of `Decktet::Card` objects. This method returns `self`.


```ruby

p = Decktet::Pile.new(card_1, card_2, card_3, card_4)

p.cards       # => [card_1, card_2, card_3, card_4]

p.size        # => 4

p.shuffle     # => p
p.cards       # => [card_4, card_1, card_3, card_2]

p.cut(1)      # => p
p.cards       # => [card_1, card_3, card_2, card_4]

p.draw(2)     # => [card_1, card_3]
p.cards       # => [card_2, card_4]

p.add(card_5) # => p
p.cards       # => [card_5, card_1, card_3]
```

### Deck

The `Decktet::Deck` class is a subclass of `Decktet::Pile` that does not allow instantiation with an empty set. 

Additionally, `Decktet::Deck` defines some helper methods for instantiating a new deck based on templates defined in `Decktet::DeckTemplates`.

```ruby
Decktet::Deck.new_basic_deck

# The above is equivalent to:
Decktet::Deck.new(Decktet::DeckTemplates::BASIC_DECK)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
