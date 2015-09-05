assert = chai.assert

describe 'dealing', ->
  deck = null
  hand = null
  app = null

  beforeEach ->
    app = new App()
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'deal to player', ->
    it 'should deal two cards to the player in each round', ->
      assert.strictEqual hand.length, 2

    it 'should deal from the same deck', ->
      assert.strictEqual deck.length, 50
      newHand = deck.dealPlayer()
      assert.strictEqual deck.length, 48
      newHand = deck.dealPlayer()
      assert.strictEqual deck.length, 46

    it 'should deal a new round', ->
      until hand.scores()[0] > 21
        hand.hit()
      
  describe 'dealer play', ->
    it 'should deal two cards to the dealer', ->
      dealerHand = deck.dealDealer()
      assert.strictEqual dealerHand.length, 2

    it 'should deal until the dealer total reaches 17', ->
      debugger;
      dealerHand = deck.dealDealer()
      app.dealerPlay()
      assert.isAbove(dealerHand.scores()[0], 16)
      # expect(dealerHand.scores[0]).to.be.above 16
      # expect(10).to.be.above(5);

  describe 'rules', ->
    it "should bust when player's score reaches above 21", ->
      until hand.scores()[0] > 21
        hand.hit()
      assert.strictEqual app.attributes.scores['busts'], 1
    it 'should alert push when hands are equal', ->

    it 'should alert when dealer wins', ->

    it 'should alert when player wins', ->




