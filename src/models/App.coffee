
# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  scores = {
    player: 0,
    dealer: 0, 
    pushes: 0, 
    busts: 0 
  }
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'scores', scores

    @get('playerHand').on 'roundOver', => 
      @removeOldHands(@get('playerHand'))
      @removeOldHands(@get('dealerHand'))
      scores['busts'] +=1
      @scoreKeeper()
    
   
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
    debugger;
    until @get('dealerHand').scores()[0] >= 17
      @get('dealerHand').hit()
      console.log @get('dealerHand').scores()[0]
    @scoreKeeper()
    # @trigger 'newStuff', @

    # if @get('playerHand').scores()[0] is @get('dealerHand').scores()[0]
    #   alert 'Push'
    # else if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0] < 22 
    #   alert 'Dealer wins'
    # else 
    #   alert 'You win!'
    # @removeOldHands(@get('playerHand'))
    # @removeOldHands(@get('dealerHand'))



  scoreKeeper: ->
    if @get('playerHand').scores()[0] is @get('dealerHand').scores()[0]
      alert 'Push'
      scores['pushes'] +=1 
    else if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0] < 22 
      alert 'Dealer wins'
      scores['dealer'] +=1
    else 
      alert 'You win!'
      scores['player'] +=1

    # console.log scores['player']  
    @removeOldHands(@get('playerHand'))
    @removeOldHands(@get('dealerHand'))
