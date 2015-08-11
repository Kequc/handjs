mocha  = require('mocha')
expect = require('chai').expect
assert = require('chai').assert
Hand   = require('../src/hand')

describe 'hand.js', ->

  cards =
    'ah': { rank: 'ace', suit: 'hearts' }
    'ad': { rank: 'ace', suit: 'diamonds' }
    'kh': { rank: 'king', suit: 'hearts' }
    'kd': { rank: 'king', suit: 'diamonds' }
    'qh': { rank: 'queen', suit: 'hearts' }
    'qd': { rank: 'queen', suit: 'diamonds' }
    'jh': { rank: 'jack', suit: 'hearts' }
    'jd': { rank: 'jack', suit: 'diamonds' }
    'th': { rank: '10', suit: 'hearts' }
    'td': { rank: '10', suit: 'diamonds' }
    '9h': { rank: '9', suit: 'hearts' }
    '9d': { rank: '9', suit: 'diamonds' }
    '9c': { rank: '9', suit: 'clubs' }
    '9s': { rank: '9', suit: 'spades' }
    '8d': { rank: '8', suit: 'diamonds' }
    '7h': { rank: '7', suit: 'hearts' }
    '7d': { rank: '7', suit: 'diamonds' }
    '7c': { rank: '7', suit: 'clubs' }
    '7s': { rank: '7', suit: 'spades' }
    '6d': { rank: '6', suit: 'diamonds' }
    '5h': { rank: '5', suit: 'hearts' }
    '5d': { rank: '5', suit: 'diamonds' }
    '5c': { rank: '5', suit: 'clubs' }
    '5s': { rank: '5', suit: 'spades' }
    '3h': { rank: '3', suit: 'hearts' }
    '3d': { rank: '3', suit: 'diamonds' }

  describe 'common hands', ->

    sets =
      'royal flush': [
        [cards['ah'], cards['kh'], cards['qh'], cards['jh'], cards['th']]
        [cards['td'], cards['ad'], cards['kd'], cards['qd'], cards['jd']]
      ]
      'straight flush': [
        [cards['kh'], cards['qh'], cards['jh'], cards['th'], cards['9h']]
        [cards['td'], cards['7d'], cards['9d'], cards['8d'], cards['6d']]
      ]
      'four of a kind': [
        [cards['7h'], cards['7d'], cards['7c'], cards['7s'], cards['9s']]
        [cards['5h'], cards['5s'], cards['9s'], cards['5d'], cards['5c']]
      ]
      'full house': [
        [cards['7h'], cards['7d'], cards['7c'], cards['9d'], cards['9s']]
        [cards['kh'], cards['9h'], cards['9c'], cards['kd'], cards['9d']]
      ]
      'flush': [
        [cards['ah'], cards['qh'], cards['th'], cards['7h'], cards['5h']]
        [cards['6d'], cards['kd'], cards['9d'], cards['8d'], cards['5d']]
      ]
      'straight': [
        [cards['kd'], cards['qh'], cards['jh'], cards['th'], cards['9d']]
        [cards['5d'], cards['6d'], cards['9c'], cards['7s'], cards['8d']]
      ]
      'three of a kind': [
        [cards['7h'], cards['7d'], cards['7c'], cards['ah'], cards['5h']]
        [cards['9h'], cards['9s'], cards['9d'], cards['5s'], cards['kd']]
      ]
      'two pair': [
        [cards['7h'], cards['7d'], cards['5h'], cards['5c'], cards['ah']]
        [cards['ah'], cards['5s'], cards['ad'], cards['9d'], cards['9s']]
      ]
      'one pair': [
        [cards['5h'], cards['5c'], cards['9h'], cards['kd'], cards['ah']]
        [cards['6d'], cards['qd'], cards['5c'], cards['qh'], cards['ah']]
      ]
      'high card': [
        [cards['kh'], cards['jh'], cards['9d'], cards['7c'], cards['5c']]
        [cards['jh'], cards['qd'], cards['7h'], cards['5s'], cards['9d']]
      ]

    it 'detects each', ->
      for name, list of sets
        for set in list
          hand = Hand set
          expect(hand.name).to.equal(name)

    it 'detects none', ->
      hand = Hand [cards['5h'], cards['5c']]
      expect(hand.name).to.equal('nothing')
      expect(hand.value).to.equal(0)

    it 'concatonates card sets', ->
      c = sets['full house'][0]
      hand = Hand c, [cards['5s'], cards['7s']]
      expect(hand.name).to.equal('four of a kind')
      hand = Hand c, [cards['7s'], cards['5s']]
      expect(hand.name).to.equal('four of a kind')
      hand = Hand c, [cards['5s']], [cards['7s']]
      expect(hand.name).to.equal('four of a kind')
      hand = Hand c, [cards['7s']], [cards['5s']]
      expect(hand.name).to.equal('four of a kind')

    describe 'winning scenario', ->

      winner = (win, lose) ->
        expect(Hand(win).value).to.be.above(Hand(lose).value)

      it 'high card king beats high card queen', ->
        winner sets['high card'][0], sets['high card'][1]

      it 'four of a kind high card ace beats four of a kind high card nine', ->
        c = sets['four of a kind'][0]
        winner c.concat([cards['ah'], cards['5s']]), c.concat([cards['5h'], cards['5d']])

      it 'four of a kind high card ten beats four of a kind high card five', ->
        c = sets['four of a kind'][1]
        winner c.concat([cards['th'], cards['3h']]), c.concat([cards['3h'], cards['3d']])

      it 'two pair beats one pair', ->
        winner sets['two pair'][0], sets['one pair'][0]
