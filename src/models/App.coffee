# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    
    @get('playerHand').on 'roundOver', => @dealNewHand()
      # console.log 'come on'
      # @set 'playerHand', deck.dealPlayer()
      # @set 'dealerHand', deck.dealDealer()
      # return
      # @resetHands()
      # @dealNewHand()
      # return
   
    # @on 'newStuff', => 
    #   console.log 'heard new stuff'
    #   @resetHands()
    #   return

    @get('playerHand').on 'stand', => @dealerPlay()
      # @dealerPlay()
      # @resetHands()
      # return

    @get('deck').on 'outOfCards', => initialize()


  # resetHands: ->
  #   console.log 'resetting'
  #   @get('playerHand').reset()
  #   @get('dealerHand').reset()
  #   @dealNewHand()


  dealNewHand: ->
    console.log 'next round******************'
    # @get('playerHand').on 'roundOver', -> console.log 'round is over'
    # console.log @get 'deck'
    # until @get('playerHand').length is 0
    #   @get('playerHand').remove(@get('playerHand').length-1)

    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

    @trigger 'newStuff', @


  dealerPlay: ->  
    console.log 'inside dealerPlay ^^^^^^^^^^^^^^^^' 
    until @get('dealerHand').scores()[0] >= 17
      # @get('dealerHand').last().flip()
      @get('dealerHand').hit()
  

    if @get('playerHand').scores()[0] is @get('dealerHand').scores()[0]
      alert 'Push'
    else if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0] < 22 
      alert 'Dealer wins'
      console.log 'dealer wins'
    else 
      alert 'You win!'
      console.log 'you win'


    # @set 'playerHand', @get('deck').dealPlayer()
    # @set 'dealerHand', @get('deck').dealDealer()

    @trigger 'newStuff', @


