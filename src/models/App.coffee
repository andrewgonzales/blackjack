# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'roundOver', => 
      @removeOldHands(@get('playerHand'))
      @removeOldHands(@get('dealerHand'))
    
   
    # @on 'newStuff', -> console.log @get('playerHand')


    @get('playerHand').on 'stand', => @dealerPlay()

    @get('deck').on 'outOfCards', => initialize



  removeOldHands: (hand)->

    until cardsInHand < 1
      cardsInHand = hand.length
      hand.pop()
    @dealNewHands(hand)
  

    @trigger 'newStuff', @

  dealNewHands: (hand)->
    
    if hand.isDealer
      hand.hit().flip()
    else
      hand.hit()
    hand.hit()

    @trigger 'newStuff', @


  dealerPlay: ->  
    until @get('dealerHand').scores()[0] >= 17
      @get('dealerHand').hit()
  

    if @get('playerHand').scores()[0] is @get('dealerHand').scores()[0]
      alert 'Push'
    else if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0] < 22 
      alert 'Dealer wins'
    else 
      alert 'You win!'
    @removeOldHands(@get('playerHand'))
    @removeOldHands(@get('dealerHand'))

    @trigger 'newStuff', @


