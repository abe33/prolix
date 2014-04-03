Prolix = require '../src/prolix'

global.atom =
  inDevMode: -> true

describe 'Prolix', ->

  beforeEach ->
    spyOn(console, 'log')
    @DummyProlix = Prolix('dummy')

    expect(@DummyProlix).toBeDefined()

  describe 'calling it twice with same channel name', ->
    it 'should return the same instance', ->
      expect(Prolix('dummy')).toBe(@DummyProlix)

  describe 'included into a class', ->
    beforeEach ->
      mixin = @DummyProlix
      class @Dummy
        mixin.includeInto(this)

      @instance = new @Dummy

    describe 'the class instance', ->
      beforeEach ->
        @channel = @instance.getChannel()

      describe '::getChannel', ->
        it 'should return a channel object', ->
          expect(@channel).toBeDefined()
          expect(@channel.name).toEqual('dummy')
          expect(@channel.active).toBeFalsy()

      describe '::canLog', ->
        it 'should return false', ->
          expect(@instance.canLog()).toBeFalsy()

        describe 'when the channel is active', ->
          beforeEach -> @channel.activate()

          it 'should return true', ->
            expect(@instance.canLog()).toBeTruthy()
