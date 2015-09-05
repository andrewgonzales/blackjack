class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

    # @on 'roundOver', => @newRound()

  hit: ->
    @add(@deck.pop())
    console.log @
    console.log @scores()[0]
    # debugger;
    if @scores()[0] > 21 then @bust()
    @last()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


  stand: ->
    console.log 'standing&&&&&&&&&&&&&&&&&'
    @trigger 'stand', @

  bust: -> 
    @trigger 'roundOver', @
    # if not @isDealer
    alert 'Bust! Dealer wins'
    console.log 'bust'
    # @reset()
   

  # newRound: ->
  #   console.log 'should clear'
  #   @reset()
