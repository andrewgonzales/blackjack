class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

    @on @length is 0, @outOfCards()
    # @on 'reset', ->
    #   @dealPlayer() 
    #   @dealDealer()


  dealPlayer: -> 
    console.log 'dealing to player'
    new Hand [@pop(), @pop()], @

  dealDealer: -> 
    console.log 'dealing to dealer'
    new Hand [@pop().flip(), @pop()], @, true


  outOfCards: ->
    @trigger 'outOfCards'
  