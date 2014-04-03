Mixin = require 'mixto'

prolixes = {}

class Channel
  constructor: (@name, @active) ->
  isActive: -> @active
  activate: -> @active = true
  deactivate: -> @active = false

Prolix = (channelName, active=false) ->
  return prolixes[channelName] if prolixes[channelName]?

  prolixes[channelName] =
  class ConcreteProlix extends Mixin
    channel = new Channel(channelName, active)

    getChannel: -> channel

    log: (args...) ->
      console.log.apply(console, args) if @canLog()

    startBench: ->
      @benchmarkTimes = [new Date] if @canLog()

    markIntermediateTime: (label) ->
      if @canLog()
        time = @logIntermediateTime(label)
        @benchmarkTimes.push(time)

    endBench: (label) ->
      if @canLog()
        @markIntermediateTime(label)
        @benchmarkTimes = null

        @log '\n'

    logIntermediateTime: (label) ->
      if @canLog()
        time = new Date
        firstTime = @benchmarkTimes[0]
        lastIndex = @benchmarkTimes.length - 1

        results = "#{time - firstTime}ms"

        if lastIndex isnt 0
          lastTime = @benchmarkTimes[lastIndex]
          results += " (#{time - lastTime}ms)"

        @log "#{label}: #{results}"
        time

    canLog: -> @getChannel().active and atom.inDevMode()

module.exports = Prolix
