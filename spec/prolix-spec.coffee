Prolix = require '../src/prolix'

describe 'Prolix', ->

  beforeEach ->
    class @Dummy
      Prolix('dummy').includeInto(this)

  it 'should exist', ->
    expect(@Dummy).toBeDefined()
