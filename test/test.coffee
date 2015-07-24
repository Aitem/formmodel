assert = require "assert"

describe 'Test fromModel', ()->
  fm = require './../src/index'
  describe '#Test geo coordinates', ()->
    o =
      "extension": [
        "extension": [
            "valueString": "59.831336"
            "url": "latitude"
          ,
            "valueString": "30.408996"
            "url": "longitude"
          ]
        "url": "http://zdrav.spb.ru"
      ,
        "extension": [
            "valueString": "59.831336"
            "url": "latitude"
          ,
            "valueString": "30.408996"
            "url": "longitude"
          ]
        "url": "http://other data"
      ]
    newo =
      "extension": [
        "extension": [
            "valueString": "60"
            "url": "latitude"
          ,
            "valueString": "30"
            "url": "longitude"
          ]
        "url": "http://zdrav.spb.ru"
      ,
        "extension": [
            "valueString": "59.831336"
            "url": "latitude"
          ,
            "valueString": "30.408996"
            "url": "longitude"
          ]
        "url": "http://other data"
      ]
    m =
      coordinates:
        latitude: ''
        longitude: ''
    res =
      coordinates:
        latitude: '59.831336'
        longitude: '30.408996'
    change =
      coordinates:
        latitude: '60'
        longitude: '30'

    it '#Test geo FROM', ()->
      assert.deepEqual(fm.from(o, m), res)
    it '#Test geo TO', ()->
      assert.deepEqual(fm.to(o, change), newo)
