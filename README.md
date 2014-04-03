## Prolix

A debug and benchmark mixin for Atom modules.

```coffee
Prolix = require 'prolix'

module.exports =
class MyModule
  Prolix('my_module_channel').includeInto(this)

  someFunction: ->
    @log "in the function"

    @startBench()

    # do stuff

    @markIntermediateTime('some stuff done')

    # do more stuff

    @endBench('someFunction execution')

```
