// Generated by CoffeeScript 1.10.0
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

window.Deck = (function(superClass) {
  extend(Deck, superClass);

  function Deck() {
    return Deck.__super__.constructor.apply(this, arguments);
  }

  Deck.prototype.model = Card;

  Deck.prototype.initialize = function() {
    var i, results;
    this.add(_((function() {
      results = [];
      for (i = 0; i < 52; i++){ results.push(i); }
      return results;
    }).apply(this)).shuffle().map(function(card) {
      return new Card({
        rank: card % 13,
        suit: Math.floor(card / 13)
      });
    }));
    return this.on(this.length === 0, this.outOfCards());
  };

  Deck.prototype.dealPlayer = function() {
    return new Hand([this.pop(), this.pop()], this);
  };

  Deck.prototype.dealDealer = function() {
    return new Hand([this.pop().flip(), this.pop()], this, true);
  };

  Deck.prototype.outOfCards = function() {
    return this.trigger('outOfCards');
  };

  return Deck;

})(Backbone.Collection);
