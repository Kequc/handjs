Hand = (cards=[]) ->

  # Ranks in order
  ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']

  # Eliminate non valid cards
  cards = cards.filter (card) ->
    r = ranks.indexOf card.rank
    r > -1 && card.suit

  # Find 5 card combinations
  combinations = (cards, k) ->
    if k > cards.length
      []
    else if k == cards.length
  	  [cards]
    else if k == 1
      result = []
      for card in cards
        result.push [card]
        true
      result
    else
      result = []
      for i in [0..(cards.length - k)] by 1
        head = cards.slice(i, (i + 1))
        tails = combinations cards.slice(i + 1), (k - 1)
        for tail in tails
          result.push head.concat tail
          true
        true
      result

  # Determine hand value
  calculate = (cards) ->
    ranked = []
    flush = true
    for card, i in cards
      if i > 0 && card.suit != cards[i-1].suit
        flush = false
      r = ranks.indexOf card.rank
      ranked[r] ?= []
      ranked[r].push card
      true

    ranked = ranked.filter (rank) -> rank != undefined
    ranked.reverse()
    r1 = ranks.indexOf ranked[0][0].rank
    r2 = ranks.indexOf ranked[ranked.length-1][0].rank
    straight = (r1 - r2) == 4

    result =
      cards: cards
    val = 0
    if straight && flush && r1 == 12
      # Royal flush
      result.name = 'royal flush'
      val = 9
    else if straight && flush
      # Straight flush
      result.name = 'straight flush'
      val = 8
    else if ranked[0].length == 4
      # 4 of a kind
      result.name = 'four of a kind'
      val = 7
    else if ranked[0].length == 3 && ranked[1].length == 2
      # Full house
      result.name = 'full house'
      val = 6
    else if flush
      # Flush
      result.name = 'flush'
      val = 5
    else if straight
      # Straight
      result.name = 'straight'
      val = 4
    else if ranked[0].length == 3
      # 3 of a kind
      result.name = 'three of a kind'
      val = 3
    else if ranked[0].length == 2 && ranked[1].length == 2
      # 2 pair
      result.name = 'two pair'
      val = 2
    else if ranked[0].length == 2
      # 1 pair
      result.name = 'one pair'
      val = 1
    else
      # High card
      result.name = 'high card'

    # Value of hand
    str = ''
    for rank in ranked
      r = ranks.indexOf(rank[0].rank)
      v = if r < 10 then '0' else ''
      v += r
      for i in [0...(ranked.length - 1)] by 1
        str += v
        true
      true
    result.value = (val * 10000000000) + parseInt(str)

    result

  best =
    cards: cards
    name: 'nothing'
    value: 0

  sets = combinations cards, 5
  for set in sets
    result = calculate set
    best = result if best.value < result.value
    true

  return best

# Export
if typeof module == "object" and typeof module.exports == "object"
  module.exports = Hand
else
  window.Hand = Hand
