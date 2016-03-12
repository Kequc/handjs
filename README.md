# Hand.js

<img src="https://raw.githubusercontent.com/Kequc/handjs/master/images/cards.jpg" alt="Cards" width="300" height="225" />

*Notice:* Repo moved to bitbucket https://bitbucket.org/Kequc/pokerhandjs

Companion module for [deckjs](https://github.com/Kequc/deckjs).

### Usage

Include `hand.js` into your page:
```html
<script src="hand.js"></script>
```

Analyse a set of cards:
```javascript
var cards = [
  { rank: "10", suit: "clubs" },
  { rank: "9", suit: "hearts" },
  { rank: "8", suit: "hearts" },
  { rank: "7", suit: "diamonds" },
  { rank: "jack", suit: "clubs" }
];
var hand = Hand(cards);
#=> {
  cards: [
    { rank: "10", suit: "clubs" },
    { rank: "9", suit: "hearts" },
    { rank: "8", suit: "hearts" },
    { rank: "7", suit: "diamonds" },
    { rank: "jack", suit: "clubs" }
  ],
  name: "straight",
  value: 40908070605
}
```

Add as many card sets together as you like:
```javascript
var hand = Hand(cards, [
  { rank: "queen", suit: "clubs" },
  { rank: "king", suit: "clubs" },
  { rank: "ace", suit: "clubs" }
]);
#=> {
  cards: [
    { rank: "10", suit: "clubs" },
    { rank: "jack", suit: "clubs" },
    { rank: "queen", suit: "clubs" },
    { rank: "king", suit: "clubs" },
    { rank: "ace", suit: "clubs" }
  ],
  name: "royal flush",
  value: 91211100908
}
```

### Result

What the result means:
```
cards:
These are the cards which were valid to make the hand.

name:
royal flush
straight flush
four of a kind
full house
flush
straight
three of a kind
two pair
one pair
high card
nothing

value:
A number which can be compared against other hands to find the winner.
```

### Limits

* Cards which are to be analysed are expected have both rank and suit.
* Cards must have a valid poker rank.
```
2 3 4 5 6 7 8 9 10 jack queen king ace
```
* Must provide at least 5 cards in order to return a hand with expected value greater than 0.
