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
      coordinates: ['','']
    res =
      coordinates: ['59.831336', '30.408996']
    change =
      coordinates: [ '60', '30']

    it '#Test geo FROM', ()->
      assert.deepEqual(fm.from(o, m), res)
    it '#Test geo TO', ()->
      assert.deepEqual(fm.to(o, change), newo)

  describe '#Test string and number first level fields', ()->
    o =
      name: 'Name before'
      numb: 5
      obj:
        foo: 'bar'
    m =
      name: ''
      numb: ''
    res =
      name: 'Name before'
      numb: 5
      obj:
        foo: 'bar'
    change =
      name: 'Name after'
      numb: 7
      obj:
        foo: 'baz'
    newo =
      name: 'Name after'
      numb: 7
      obj:
        foo: 'baz'

    it '#Test From first level fields', ()->
      assert.deepEqual(fm.from(o, m), res)
    it '#Test TO first level fields', ()->
      assert.deepEqual(fm.to(o, change), newo)
  
  describe '#Test address field', ()->
    o =
      address: [ text: 'Address before']
      numb: 5
      obj:
        foo: 'bar'
    m =
      address: ''
      name: ''
      numb: ''
    res =
      address: 'Address before'
      name: ''
      numb: 5
      obj:
        foo: 'bar'
    change =
      address: 'Address after'
      name: 'Name after'
      numb: 7
    newo =
      address: [ text: 'Address after']
      name: 'Name after'
      numb: 7
      obj:
        foo: 'bar'

    it '#Test FROM address', ()->
      assert.deepEqual(fm.from(o, m), res)
    it '#Test TO address', ()->
      assert.deepEqual(fm.to(o, change), newo)
  
  describe '#Test OrgType', ()->
    o =
      type:
        "coding": [
            "display": "Гинекологические"
            "system": "OrgType"
            "code": "10293"
          ,
            "display": "Анкология"
            "system": "OtherType"
            "code": "10277"
          ]
    m =
      orgtype:
        code: ''
        system: 'OrgType'
        display: ''
    res =
      orgtype:
        code: '10293'
        system: 'OrgType'
        display: "Гинекологические"
    change =
      orgtype:
        code: '10999'
        display: "Хирургия"
    newo =
      type:
        "coding": [
            "display": "Хирургия"
            "system": "OrgType"
            "code": "10999"
          ,
            "display": "Анкология"
            "system": "OtherType"
            "code": "10277"
          ]

    it '#Test FROM OrgType', ()->
      assert.deepEqual(fm.from(o, m), res)
    it '#Test TO OrgType', ()->
      assert.deepEqual(fm.to(o, change), newo)
