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
    # Add card to hand

    if card and card.suit and card.rank
      card =
        suit: card.suit
        rank: card.rank
      @cards.push card
      card
    else
      false

  result: =>
    # Find value of hand



# Export
if typeof module == "object" and typeof module.exports == "object"
  module.exports = Hand
else
  window.Hand = Hand
