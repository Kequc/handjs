class Hand

  constructor: (cards=[]) ->
    # Instantiate a hand

    @cards = []
    @types = [
      'royal flush',
      'straight flush',
      'four of a kind',
      'full house',
      'flush',
      'straight',
      'three of a kind',
      'two pair',
      'one pair',
      'high card'
    ]

    @inlay card for card in cards

  inlay: (card) =>
    # Add card

    if card and card.suit and card.rank
      card =
        suit: card.suit
        rank: card.rank
      @cards.push card
      card
    else
      false

  result: =>
    # Find value

    # Cards put into ranked order
    ranked = []
    for card in @cards
      high = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace'].indexOf card.rank
      if high > -1
        ranked[high] ?= []
        ranked[high].push card

    # Important hand related attributes
    sequential =
      count: 0
      high: 0
    sames = []
    kickers = []

    sequence = 0
    for cards, high in ranked
      # Sequential
      if cards
        sequence++
      else
        if sequential.count < sequence || (sequential.count == sequence && sequential.high < high)
          sequential.count = sequence
          sequential.high = high
        count = 0
      # Same
      if cards
        if cards.length > 1
          sames.push
            count: cards.length
            high: high
        else
          kickers.push card

    # Determine hand type
    if sequential.count >= 5
      suit = null
      count = 0
      for i in [sequential.high..(sequential.high-sequential.count)]
        if ranked[i].suit == suit
          count++
        else
          suit = ranked[i].suit
          count = 1
      if count >= 5 && sequential.high == 12
        # Royal flush
      else if count >= 5
        # Straight flush
      else
        # Straight

    # More hand types
    for same in sames
      switch same.count
        when 4
          # Four of a kind
        when 3
          # Three of a kind
        when 2
          # One pair

    # Tip: For the future remember to make use of the kickers when calculating 4 3 2 of a kind.
    # Tip: Make sure to watch for full houses and two pairs.
    # Tip: So more calculation after finding hand type matches necessary.

# Export
if typeof module == "object" and typeof module.exports == "object"
  module.exports = Hand
else
  window.Hand = Hand
