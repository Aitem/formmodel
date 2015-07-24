assert = require "assert"

describe 'Test', ()->
  fm = require './../lib/index'
  it '#Test', ()->
    fm = require './../lib/index'

    o =
      f: [{foo: 5}, {bar: 'baz'}]

    m = {foo: {} , bar: {}}
    m = fm.fromModel(o, m)

    e =
      foo: 5
      bar: 'baz'

    assert.deepEqual(m, e)
