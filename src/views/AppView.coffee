class window.AppView extends Backbone.View
  template: _.template '
    <div class="scoreRecord">Player: <%= scores["player"]%>  Dealer: <%= scores["dealer"]%>  Pushes: <%= scores["pushes"]%> </div>
    <div class="button-div">
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    </div>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'all', @render, @ 
    @model.on 'change:[playerHand]', @render, @

    @render()

  render: ->
    @$el.children().detach()
    # @$el.html @template()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @delegateEvents()
    @
