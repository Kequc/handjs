# Return the best poker hand from a set of cards
Hand = (cards=[]) ->

  # Eliminate non valid cards
  cards = cards.filter (card) ->
    r = _ranks.indexOf card.rank
    r > -1 && card.suit

  best =
    cards: cards
    name: 'nothing'
    value: 0

  sets = _combinations cards, 5
  for set in sets
    result = _calculate set
    best = result if best.value < result.value

  best

# Ranks in order
_ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']

_combinations = (cards, k) ->
  # Find 5 card combinations

  if k > cards.length
    []
  else if k == cards.length
	  [cards]
  else if k == 1
    result = []
    for card in cards
      result.push [card]
    result
  else
    result = []
    for i in [0..(cards.length - k)] by 1
      head = cards.slice(i, (i + 1))
      tails = _combinations cards.slice(i + 1), (k - 1)
      for tail in tails
        result.push head.concat tail
    result

_calculate = (cards) ->
  # Determine value of hand

  ranked = []
  flush = true
  for card, i in cards
    if i > 0 && card.suit != cards[i-1].suit
      flush = false
    r = _ranks.indexOf card.rank
    ranked[r] ?= []
    ranked[r].push card

  ranked = ranked.filter (rank) -> rank != undefined
  ranked.reverse()
  ranked.sort (a, b) ->
    if a.length > b.length then -1 else if a.length < b.length then 1 else 0
  r1 = _ranks.indexOf ranked[0][0].rank
  if ranked[4]
    r2 = _ranks.indexOf ranked[4][0].rank
  straight = r2 && ((r1 - r2) == 4)

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
    r = _ranks.indexOf rank[0].rank
    v = if r < 10 then '0' else ''
    v += r
    for card in rank
      str += v
  result.value = (val * 10000000000) + parseInt(str)

  result

# Export
if typeof module == "object" and typeof module.exports == "object"
  module.exports = Hand
else
  window.Hand = Hand
